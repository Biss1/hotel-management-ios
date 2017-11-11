//
//  DataAPI.swift
//  HotelManagement
//
//  Created by Bisera Belkoska on 02.11.17.
//  Copyright © 2017 Bisera Belkoska. All rights reserved.
//

import Foundation
import RealmSwift

fileprivate func realmInMemory(_ name: String) -> Realm {
    var conf = Realm.Configuration()
    conf.inMemoryIdentifier = name
    return try! Realm(configuration: conf)
}

fileprivate func addRooms(_ realm: Realm) {
    let rooms: [Room] = [Room(id: 1, roomNumber: "1"), Room(id: 2, roomNumber: "2"),
                         Room(id: 3, roomNumber: "5"), Room(id: 4, roomNumber: "6")]
    
    try! realm.write {
        realm.add(rooms)
    }
}

fileprivate func getRealm() -> Realm {
    if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
        // Code only executes when tests are running
        return realmInMemory("HotelManagementTests")
    }
    return realmInMemory("HotelManagement")
}

struct DataService {
    
    static func getRoomReservations(period: Period) -> Results<RoomReservation> {
        let realm = getRealm()
        let predicate = NSPredicate(format: "dateFrom =< %@ && dateTo >= %@", argumentArray: [period.dateTo, period.dateFrom])
        return realm.objects(RoomReservation.self).filter(predicate)
    }
    
    static func getAvailableRooms(period: Period) -> Results<Room> {
        let realm = getRealm()
        var predicate = NSPredicate(format: "dateFrom < %@ && dateTo > %@", argumentArray: [period.dateTo, period.dateFrom])
        let roomIds = realm.objects(RoomReservation.self).filter(predicate).map { $0.room.id }
        predicate = NSPredicate(format: "NOT (id IN %@)", Array(roomIds))
        return realm.objects(Room.self).filter(predicate)
    }
    
    static func getRooms() -> Results<Room> {
        let realm = getRealm()
        return realm.objects(Room.self)
    }
    
    static func getRoom(id: Int) -> Room? {
        let realm = getRealm()
        let predicate = NSPredicate(format: "id == %d", id)
        return realm.objects(Room.self).filter(predicate).first
    }
    
    static func isRoomAvailableDayBefore(date: Date, room: Room) -> Bool {
        let realm = getRealm()
        let predicateFormat = "dateFrom < %@ && dateTo > %@ && room.id = %@"
        let predicate = NSPredicate(format: predicateFormat, argumentArray: [date.getPreviousDay(), date, room.id])
        let rooms = realm.objects(Room.self).filter(predicate)
        return rooms.count > 0
    }
    
    static func isRoomAvailableDayAfter(date: Date, room: Room) -> Bool {
        let realm = getRealm()
        let predicateFormat = "dateFrom < %@ && dateTo > %@ && room.id = %@"
        let predicate = NSPredicate(format: predicateFormat, argumentArray: [date, date.getNextDay(), room.id])
        let rooms = realm.objects(Room.self).filter(predicate)
        return rooms.count > 0
    }
    
    static func calculateGaps(roomAvailability: [RoomAvailability]) -> Int {
        return roomAvailability.map{(roomAvailability: RoomAvailability) -> Int in
            var count = 0
            let gapBefore = isRoomAvailableDayBefore(date: roomAvailability.period.dateFrom, room: roomAvailability.room)
            let gapAfter = isRoomAvailableDayAfter(date: roomAvailability.period.dateTo, room: roomAvailability.room)
            count += gapBefore ? 1 :0
            count += gapAfter ? 1 : 0
            return count
            }.reduce(0, +)
    }
    
    static func getAvailableRoomsWithTransfer(period: Period) -> [AvailabilityWithTransfer] {
        var date = Calendar.current.date(byAdding: .day, value: 1, to: period.dateFrom!)!
        var availabilityList = [AvailabilityWithTransfer]()
        while date <= period.dateTo  {
            let roomsFirst = Array(getAvailableRooms(period: Period(dateFrom: period.dateFrom, dateTo: date)))
            let roomsSecond = Array(getAvailableRooms(period: Period(dateFrom: date, dateTo: period.dateTo)))
            if roomsFirst.count == 0 || roomsSecond.count == 0 {
                date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
                continue
            }
            for room1 in roomsFirst {
                for room2 in roomsSecond {
                    let roomAvailability1 = RoomAvailability(room: room1, period: Period(dateFrom: period.dateFrom, dateTo: date));
                    let roomAvailability2 = RoomAvailability(room: room2, period: Period(dateFrom: date, dateTo: period.dateTo));
                    let list = [roomAvailability1, roomAvailability2]
                    let availability = AvailabilityWithTransfer(roomAvailability: list, numberOfGaps: calculateGaps(roomAvailability: list))
                    availabilityList.append(availability)
                }
            }
            date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
        }
        return availabilityList
    }
    
//    func sortByPrefferedRoom(availabilities: [AvailabilityWithTransfer], room: Room) -> [AvailabilityWithTransfer] {
////        return availabilities.sorted { (firstPossibility, secondPossibility) -> Bool in
////         }
//    }
    
    static func getRoomAvailability(period: Period) -> [RoomAvailability] {
        let rooms = getAvailableRooms(period: period).toArray()
        let availableRooms = rooms.map { (room: Room) -> RoomAvailability in
            RoomAvailability(room: room, period: period)
        }
        return availableRooms
    }
    
    static func getAvailability(period: Period) -> Availability {
        return Availability(roomAvailability: getRoomAvailability(period: period),
                            availabilityWithTransfer: getAvailableRoomsWithTransfer(period: period))
    }
    
}

extension Date {
    func getNextDay() -> Date! {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
    
    func getPreviousDay() -> Date! {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
}

struct RoomAvailableDates {
//    let room: Room
//    let periods: [Period]
//    let dates: [Date]
}

struct Availability {
    let roomAvailability: [RoomAvailability]
    let availabilityWithTransfer: [AvailabilityWithTransfer]
}

struct AvailabilityWithTransfer {
    let roomAvailability: [RoomAvailability]
    var numberOfTransfers: Int {
        return roomAvailability.count - 1
    }
    var numberOfGaps = 0
}

struct RoomAvailability {
    let room: Room
    let period: Period
}

struct Period {
    var dateFrom: Date!
    var dateTo: Date!
    var daysBetween: Int? {
        return NSCalendar.current.dateComponents([.day], from: dateFrom, to: dateTo).day
    }
    
    init(dateFrom: Date, dateTo:Date) {
        self.dateFrom = dateFrom
        self.dateTo = dateTo
    }
    
    init(dateFrom: Date) {
        self.dateFrom = dateFrom
        self.dateTo = Calendar.current.date(byAdding: .day, value: 1, to: dateFrom)!
    }
}

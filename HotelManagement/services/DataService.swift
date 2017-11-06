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

struct DataService {
    
    static func getReservations(period: Period) -> Results<Reservation> {
        let realm = realmInMemory("HotelManagement")
        let predicate = NSPredicate(format: "dateFrom <= %@ && dateTo >= %@", argumentArray: [period.dateTo, period.dateFrom])
        return realm.objects(Reservation.self).filter(predicate)
    }
    
    static func getAvailableRooms(period: Period) -> Results<Room> {
        let realm = realmInMemory("HotelManagement")
        let roomNumbers = getReservations(period: period).map { $0.roomNumber!}
        let predicate = NSPredicate(format: "NOT (roomNumber IN %@)", Array(roomNumbers))
        return realm.objects(Room.self).filter(predicate)
    }
    
    static func getAvailableRoomsWithTransfer(period: Period) -> [AvailabilityWithTransfer] {
        return []
    }
    
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

struct Availability {
    let roomAvailability: [RoomAvailability]
    let availabilityWithTransfer: [AvailabilityWithTransfer]
}

struct AvailabilityWithTransfer {
    let roomAvailability: [RoomAvailability]
    var numberOfTransfers: Int {
        return roomAvailability.count
    }
}

struct RoomAvailability {
    let room: Room
    let period: Period
}

struct Period {
    var dateFrom: Date!
    var dateTo: Date!
    
    init(dateFrom: Date, dateTo:Date) {
        self.dateFrom = dateFrom
        self.dateTo = dateTo
    }
}

//
//  AvailabilityUtils.swift
//  HotelManagement
//
//  Created by Bisera Belkoska on 03.12.17.
//  Copyright © 2017 Bisera Belkoska. All rights reserved.
//

import Foundation

struct Availability {
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

/** Calculate availability without transfers in period */
func getAvailableRooms(period: Period) -> [RoomAvailability] {
    let rooms = DataService.getAvailableRooms(period: period).toArray()
    let availableRooms = rooms.map { (room: Room) -> RoomAvailability in
        return  RoomAvailability(room: room, period: period)
    }
    return availableRooms
}

/** Calculate availability with 1 transfer in period */
func getAvailableRoomsWithTransfer(period: Period) -> [Availability] {
    var date = Calendar.current.date(byAdding: .day, value: 1, to: period.dateFrom!)!
    var availabilityList = [Availability]()
    while date <= period.dateTo  {
        let roomsFirst = Array(DataService.getAvailableRooms(period: Period(dateFrom: period.dateFrom, dateTo: date)))
        let roomsSecond = Array(DataService.getAvailableRooms(period: Period(dateFrom: date, dateTo: period.dateTo)))
        if roomsFirst.count == 0 || roomsSecond.count == 0 {
            date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
            continue
        }
        for room1 in roomsFirst {
            for room2 in roomsSecond {
                let roomAvailability1 = RoomAvailability(room: room1, period: Period(dateFrom: period.dateFrom, dateTo: date));
                let roomAvailability2 = RoomAvailability(room: room2, period: Period(dateFrom: date, dateTo: period.dateTo));
                let list = [roomAvailability1, roomAvailability2]
                let availability = Availability(roomAvailability: list, numberOfGaps: calculateGaps(roomAvailability: list))
                availabilityList.append(availability)
            }
        }
        date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
    }
    return availabilityList
}

func calculateGaps(roomAvailability: [RoomAvailability]) -> Int {
    return roomAvailability.map{(roomAvailability: RoomAvailability) -> Int in
        var count = 0
        let gapBefore = isRoomAvailableDayBefore(date: roomAvailability.period.dateFrom, room: roomAvailability.room)
        let gapAfter = isRoomAvailableDayAfter(date: roomAvailability.period.dateTo, room: roomAvailability.room)
        count += gapBefore ? 1 :0
        count += gapAfter ? 1 : 0
        return count
        }.reduce(0, +)
}

func isRoomAvailableDayBefore(date: Date, room: Room) -> Bool { //TODO fix this and write tests
    let rooms = DataService.getAvailableRooms(period: Period(dateFrom: date))
    let predicate = NSPredicate(format: "id == %d", room.id)
    return rooms.filter(predicate).count > 0
}

func isRoomAvailableDayAfter(date: Date, room: Room) -> Bool { //TODO fix this and write tests
    let rooms = DataService.getAvailableRooms(period: Period(dateFrom: date))
    let predicate = NSPredicate(format: "id == %d", room.id)
    return rooms.filter(predicate).count > 0
}


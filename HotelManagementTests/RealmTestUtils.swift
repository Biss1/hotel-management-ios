//
//  TestUtils.swift
//  HotelManagementTests
//
//  Created by Bisera Belkoska on 07.11.17.
//  Copyright © 2017 Bisera Belkoska. All rights reserved.
//

import Foundation
import RealmSwift
@testable import HotelManagement

func defaultFormatter() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yyyy"
    formatter.timeZone = TimeZone(abbreviation: "UTC")
    return formatter
}

func setupRealm() {
    let realm = realmInMemory("HotelManagementTests")
    clearRealm(realm)
    addRooms(realm)
}

func realmInMemory(_ name: String) -> Realm {
    var conf = Realm.Configuration()
    conf.inMemoryIdentifier = name
    return try! Realm(configuration: conf)
}

func clearRealm(_ realm: Realm) {
    try! realm.write {
        realm.deleteAll()
    }
}

func addRooms(_ realm: Realm) {
    let rooms: [Room] = [Room(id: 1, roomNumber: "1"), Room(id: 2, roomNumber: "2"),
                         Room(id: 3, roomNumber: "5"), Room(id: 4, roomNumber: "6")]
    
    try! realm.write {
        realm.add(rooms)
    }
}

func addReservation12thTo18th() {
    addReservationForPeriod(period: Period(dateFrom: defaultFormatter().date(from: "12.04.2012")!,
                                           dateTo: defaultFormatter().date(from: "18.04.2012")!),
                            room: DataService.getRoom(id: 1)!)
}

func addReservationForPeriod(period: Period, room: Room) {
    let realm = realmInMemory("HotelManagementTests")
//    var reservations: [Reservation] = []
    
//    let res = Reservation()
    let roomRes = RoomReservation()
    roomRes.dateFrom = period.dateFrom
    roomRes.dateTo = period.dateTo
    roomRes.room = room
    
//    res.id = 1
//    res.roomReservations =  [roomRes]
    
//    reservations.append(res)
    
    do {
        try realm.write() {
            realm.add(roomRes)
        }
    } catch let error as NSError {
        print(error)
    }
}

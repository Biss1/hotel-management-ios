//
//  RoomsAvailableInPeriodTests.swift
//  HotelManagementTests
//
//  Created by Bisera Belkoska on 02.11.17.
//  Copyright © 2017 Bisera Belkoska. All rights reserved.
//

import XCTest
import RealmSwift
@testable import HotelManagement

class AvailabilityInPeriodTests: XCTestCase {
    
    let formatter = DateFormatter()
    
    override func setUp() {
        super.setUp()
        formatter.dateFormat = "dd.MM.yyyy"
        
        let realm = realmInMemory("HotelManagement")
        clearRealm(realm)
        addRooms(realm)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func addRooms(_ realm: Realm) {
        let rooms: [Room] = [Room(id: 1, roomNumber: "1"), Room(id: 2, roomNumber: "2"),
                             Room(id: 3, roomNumber: "5"), Room(id: 4, roomNumber: "6")]
        
        try! realm.write {
            realm.add(rooms)
        }
    }
    
    fileprivate func realmInMemory(_ name: String) -> Realm {
        var conf = Realm.Configuration()
        conf.inMemoryIdentifier = name
        return try! Realm(configuration: conf)
    }
    
    fileprivate func clearRealm(_ realm: Realm) {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func testAvailableRoomsOneReservation() {
        addReservation12thTo18th()
        
        let period = Period(dateFrom: formatter.date(from: "12.04.2012")!, dateTo: formatter.date(from: "16.04.2012")!)
        let rooms = DataService.getAvailableRooms(period: period)
        
        XCTAssertEqual(rooms.count, 3)
    }
    
    func addReservation12thTo18th() {
        let realm = realmInMemory("HotelManagement")
        var reservations: [Reservation] = []
        
        let res = Reservation()
        res.dateFrom = formatter.date(from: "12.04.2012")
        res.dateTo = formatter.date(from: "18.04.2012")
        res.roomNumber = "1"
        reservations.append(res)
        
        try! realm.write {
            realm.add(reservations)
        }
    }
}

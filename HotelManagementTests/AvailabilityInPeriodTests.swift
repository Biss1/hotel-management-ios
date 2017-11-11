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
        setupRealm()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAvailableRoomsOneReservation() {
        addReservation12thTo18th()
        
        let period = Period(dateFrom: defaultFormatter().date(from: "12.04.2012")!, dateTo: defaultFormatter().date(from: "16.04.2012")!)
        let rooms = DataService.getAvailableRooms(period: period)
        
        XCTAssertEqual(rooms.count, 3)
    }
    
    func testAvailableRoomWithPeriodSameDateFrom() {
         let period = Period(dateFrom: defaultFormatter().date(from: "14.05.2012")!,
                             dateTo: defaultFormatter().date(from: "16.05.2012")!)
        addReservationForPeriod(period: period, room: DataService.getRoom(id: 2)!)

        let periodFree = Period(dateFrom: defaultFormatter().date(from: "11.05.2012")!, dateTo: defaultFormatter().date(from: "14.05.2012")!)
        let rooms = DataService.getAvailableRooms(period: periodFree)
        
        XCTAssertEqual(rooms.count, 4)
    }
}

//
//  AvailabilityTests.swift
//  HotelManagementTests
//
//  Created by Bisera Belkoska on 01.11.17.
//  Copyright © 2017 Bisera Belkoska. All rights reserved.
//

import XCTest
@testable import HotelManagement

class AvailabilityWithTransfersTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // TODO Add rooms for testing
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRoomAvailable() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        
       var res = Reservation()
        res.dateFrom = formatter.date(from: "12.04.2012")
        res.dateTo = formatter.date(from: "18.04.2012")
        res.roomNumber = "1"
        
        res = Reservation()
        res.dateFrom = formatter.date(from: "17.04.2012")
        res.dateTo = formatter.date(from: "23.04.2012")
        res.roomNumber = "2"
        
        //getAvailableRooms(dateFrom: Date, dateTo: Date)
        
        print(res)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

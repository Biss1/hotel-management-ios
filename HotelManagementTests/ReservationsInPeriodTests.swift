//
//  ReservationsInPeriodTests.swift
//  HotelManagementTests
//
//  Created by Bisera Belkoska on 02.11.17.
//  Copyright © 2017 Bisera Belkoska. All rights reserved.
//

import XCTest
import RealmSwift
@testable import HotelManagement

class ReservationsInPeriodTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        setupRealm()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    
    func testReservationBeforePeriod() {
        let period = Period(dateFrom: defaultFormatter().date(from: "19.04.2012")!, dateTo: defaultFormatter().date(from: "21.04.2012")!)
        let result = DataService.getRoomReservations(period: period)
        
        XCTAssert(result.isEmpty)
    }
    
    func testReservationAfterPeriod() {
        addReservation12thTo18th()
        
        let period = Period(dateFrom: defaultFormatter().date(from: "09.04.2012")!, dateTo: defaultFormatter().date(from: "11.04.2012")!)
        let result = DataService.getRoomReservations(period: period)
        
        XCTAssert(result.isEmpty)
    }
    
    func testReservationWithEndDateInPeriod() {
        addReservation12thTo18th()
        
        let period = Period(dateFrom: defaultFormatter().date(from: "16.04.2012")!, dateTo: defaultFormatter().date(from: "20.04.2012")!)
        let result = DataService.getRoomReservations(period: period)
        
        XCTAssertEqual(result.count, 1 )
    }
    
    func testReservationWithStartDateInPeriod() {
        addReservation12thTo18th()
        
        let period = Period(dateFrom: defaultFormatter().date(from: "10.04.2012")!, dateTo: defaultFormatter().date(from: "16.04.2012")!)
        let result = DataService.getRoomReservations(period: period)
        
        XCTAssertEqual(result.count, 1 )
    }
    
    func testReservationWithinPeriod() {
        addReservation12thTo18th()
        
        let period = Period(dateFrom: defaultFormatter().date(from: "10.04.2012")!, dateTo: defaultFormatter().date(from: "20.04.2012")!)
        let result = DataService.getRoomReservations(period: period)
        
        XCTAssertEqual(result.count, 1 )
    }
    
    func testReservationWithEndDateSameAsPeriod() {
        addReservation12thTo18th()
        
        let period = Period(dateFrom: defaultFormatter().date(from: "13.04.2012")!, dateTo: defaultFormatter().date(from: "18.04.2012")!)
        let result = DataService.getRoomReservations(period: period)
        
        XCTAssertEqual(result.count, 1 )
    }
    
    func testReservationWithStartDateSameAsPeriod() {
        addReservation12thTo18th()
        
        let period = Period(dateFrom: defaultFormatter().date(from: "12.04.2012")!, dateTo: defaultFormatter().date(from: "20.04.2012")!)
        let result = DataService.getRoomReservations(period: period)
        
        XCTAssertEqual(result.count, 1 )
    }
    
    func testReservationWithDatesSameAsPeriod() {
        addReservation12thTo18th()
        
        let period = Period(dateFrom: defaultFormatter().date(from: "12.04.2012")!, dateTo: defaultFormatter().date(from: "18.04.2012")!)
        let result = DataService.getRoomReservations(period: period)
        
        XCTAssertEqual(result.count, 1 )
    }

}

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
        setupRealm()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRoomAvailable() { //https://docs.google.com/document/d/1tx-oSWFvt-c1BpkP3BUe-j1XRq-CJ0NzLO913IZRWMQ/edit#
        addReservationForPeriod(period: Period(dateFrom: defaultFormatter().date(from: "08.05.2017")!,
                                               dateTo: defaultFormatter().date(from: "13.05.2017")!),
                                                room: DataService.getRoom(id: 1)!)
        
        addReservationForPeriod(period: Period(dateFrom: defaultFormatter().date(from: "14.05.2017")!,
                                               dateTo: defaultFormatter().date(from: "16.05.2017")!),
                                                room: DataService.getRoom(id: 2)!)
        
        addReservationForPeriod(period: Period(dateFrom: defaultFormatter().date(from: "13.05.2017")!,
                                               dateTo: defaultFormatter().date(from: "14.05.2017")!),
                                                room: DataService.getRoom(id: 3)!)
        
        addReservationForPeriod(period: Period(dateFrom: defaultFormatter().date(from: "16.05.2017")!,
                                               dateTo: defaultFormatter().date(from: "20.05.2017")!),
                                                room: DataService.getRoom(id: 4)!)
        
        let availableRoomsWithTransfer = getAvailableRoomsWithTransfer(period: Period(dateFrom: defaultFormatter().date(from: "11.05.2017")!,
                                                                             dateTo: defaultFormatter().date(from: "17.05.2017")!))
        print(availableRoomsWithTransfer)
        XCTAssertEqual(availableRoomsWithTransfer.count, 12)
        
        // first possibiltiy should be room 2 (2 days) + room 1 (4 days)
        checkAvailableRooms(availabilityWithTransfer: availableRoomsWithTransfer[0],
                            roomIdFirstPeriod: 2, daysFirstPeriod: 2, roomIdSecondPeriod: 1, daysSecondPeriod: 4)
        
        // second possibiltiy should be room 3 (2 days) + room 1 (4 days)
        checkAvailableRooms(availabilityWithTransfer: availableRoomsWithTransfer[1],
                            roomIdFirstPeriod: 3, daysFirstPeriod: 2, roomIdSecondPeriod: 1, daysSecondPeriod: 4)
        
        // third possibiltiy should be room 4 (2 days) + room 1 (4 days)
        checkAvailableRooms(availabilityWithTransfer: availableRoomsWithTransfer[2],
                            roomIdFirstPeriod: 4, daysFirstPeriod: 2, roomIdSecondPeriod: 1, daysSecondPeriod: 4)
        
        // sixth possibiltiy should be room 4 (3 days) + room 1 (3 days)
        checkAvailableRooms(availabilityWithTransfer: availableRoomsWithTransfer[5],
                            roomIdFirstPeriod: 4, daysFirstPeriod: 3, roomIdSecondPeriod: 1, daysSecondPeriod: 3)
        
        // 7th possibiltiy should be room 4 (3 days) + room 3 (3 days)
        checkAvailableRooms(availabilityWithTransfer: availableRoomsWithTransfer[6],
                            roomIdFirstPeriod: 4, daysFirstPeriod: 3, roomIdSecondPeriod: 3, daysSecondPeriod: 3)
        
        // 11th possibiltiy should be room 4 (5 days) + room 2 (1 day)
        checkAvailableRooms(availabilityWithTransfer: availableRoomsWithTransfer[10],
                            roomIdFirstPeriod: 4, daysFirstPeriod: 5, roomIdSecondPeriod: 2, daysSecondPeriod: 1)
        
    }
    
    func checkAvailableRooms(availabilityWithTransfer: Availability, roomIdFirstPeriod: Int,
                              daysFirstPeriod: Int, roomIdSecondPeriod: Int, daysSecondPeriod: Int) {
        XCTAssertTrue(availabilityWithTransfer.numberOfTransfers == 1)
        XCTAssertTrue(availabilityWithTransfer.roomAvailability[0].room.id == roomIdFirstPeriod)
        XCTAssertTrue(availabilityWithTransfer.roomAvailability[0].period.daysBetween == daysFirstPeriod)
        XCTAssertTrue(availabilityWithTransfer.roomAvailability[1].room.id == roomIdSecondPeriod)
        XCTAssertTrue(availabilityWithTransfer.roomAvailability[1].period.daysBetween == daysSecondPeriod)
    }
}

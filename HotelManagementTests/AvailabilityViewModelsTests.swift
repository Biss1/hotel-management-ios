//
//  AvailabilityViewModelsTests.swift
//  HotelManagementTests
//
//  Created by Bisera Belkoska on 10.12.17.
//  Copyright © 2017 Bisera Belkoska. All rights reserved.
//

import XCTest
@testable import HotelManagement

class AvailabilityViewModelsTests: XCTestCase {
    
    func testAvailableRoomsWithoutTransfer() {
        
        let room = Room(id: 1, roomNumber: "1")
        var roomAvailabilityList: [RoomAvailability] = Array()
        roomAvailabilityList.append(RoomAvailability(room: room, period: Period(dateFrom: Date())))
        
        var availability: [Availability] = []
        
        let availabilityRooms = Availability(roomAvailability: roomAvailabilityList, numberOfGaps: 0)
        availability.append(availabilityRooms)
        
        roomAvailabilityList = Array()
        roomAvailabilityList.append(RoomAvailability(room: room, period: Period(dateFrom: defaultFormatter().date(from: "05.12.2017")!)))
        availability.append(availabilityRooms)
        
        roomAvailabilityList = Array()
        roomAvailabilityList.append(RoomAvailability(room: room, period: Period(dateFrom: defaultFormatter().date(from: "08.12.2017")!)))
        availability.append(availabilityRooms)
        
        let availabilityViewModel = RoomAvailabilityViewModel(availabilityList: availability)
        
        XCTAssertEqual(availabilityViewModel.numberSections, 2)
        
        XCTAssertEqual(availabilityViewModel.sectionsViewModels.count, 2)
        XCTAssertEqual(availabilityViewModel.sectionsViewModels[0].cellViewModels.count, 3)
        
    }
    
    
}

//
//  AvailabilityCellViewModel.swift
//  HotelManagement
//
//  Created by Bisera Belkoska on 03.12.17.
//  Copyright © 2017 Bisera Belkoska. All rights reserved.
//
import Foundation

class AvailabilityCellViewModel {
    var showReserveButton: Bool!
    var showEditButton: Bool!
    
    var firstRoomText = ""
    var firstPeriodText = ""
//    var firstRoomColor
    
    var secondRoomText = ""
    var secondPeriodText = ""
//    var secondRoomColor
    
    init(roomAvailability: [RoomAvailability]) {
        firstRoomText = String(format: "Room %@", roomAvailability[0].room.roomNumber)
        firstPeriodText = periodText(period: roomAvailability[0].period)
        
        secondRoomText = roomAvailability[1].room.roomNumber
        secondPeriodText = periodText(period: roomAvailability[1].period)
        
        showReserveButton = true
        showEditButton = false
    }
    
    init(roomAvailability: RoomAvailability) {
        firstRoomText = String(format: "Room %@", roomAvailability.room.roomNumber)
        firstPeriodText = "Available"
        
        showReserveButton = true
        showEditButton = false
    }
    
    func periodText(period: Period) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd"
        
        let stringFrom = formatter.string(from: period.dateFrom)
        let stringTo = formatter.string(from: period.dateTo)
        
        return String(format: "%@ - %@", stringFrom, stringTo)
    }
}

//
//  AvailabilityCellViewModel.swift
//  HotelManagement
//
//  Created by Bisera Belkoska on 03.12.17.
//  Copyright © 2017 Bisera Belkoska. All rights reserved.
//
import Foundation

class AvailabilityCellVM {
    var showReserveButton: Bool!
    var showEditButton: Bool!
    
    var firstRoomText = ""
    var firstPeriodText = ""
//    var firstRoomColor
    
    var secondRoomText = ""
    var secondPeriodText = ""
//    var secondRoomColor
    
    init(roomAvailability: [RoomAvailability]) {
        firstRoomText = format(roomNumber: roomAvailability[0].room.roomNumber)
        firstPeriodText = format(period: roomAvailability[0].period)
        
        secondRoomText = format(roomNumber: roomAvailability[1].room.roomNumber)
        secondPeriodText = format(period: roomAvailability[1].period)
        
        showReserveButton = true
        showEditButton = false
    }
    
    init(roomAvailability: RoomAvailability) {
        firstRoomText = format(roomNumber: roomAvailability.room.roomNumber)
        firstPeriodText = "Available"
        
        showReserveButton = true
        showEditButton = false
    }
    
    func format(roomNumber: String) -> String{
        return String(format: "Room %@", roomNumber)
    }
    
    func format(period: Period) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd"
        
        let stringFrom = formatter.string(from: period.dateFrom)
        let stringTo = formatter.string(from: period.dateTo)
        
        return String(format: "%@ - %@", stringFrom, stringTo)
    }
}

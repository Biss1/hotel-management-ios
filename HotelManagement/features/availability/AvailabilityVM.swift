//
//  AvailabilityViewModel.swift
//  HotelManagement
//
//  Created by Bisera Belkoska on 02.11.17.
//  Copyright © 2017 Bisera Belkoska. All rights reserved.
//

import RxSwift
import RxRealm
import RealmSwift

class AvailabilityVM {
    
    var availableRoomsSubject: PublishSubject<AvailabilityVM> = PublishSubject<AvailabilityVM>()
    
    var sections: [AvailabilitySectionVM] = []
    
    func rangeSelected(dateFrom: Date, dateTo: Date) {
        let period = Period(dateFrom: dateFrom, dateTo: dateTo)
        
        sections.append(AvailabilitySectionVM(roomAvailability: getAvailableRooms(period: period)))
        sections.append(AvailabilitySectionVM(availabilities: getAvailableRoomsWithTransfer(period: period), numberOfTransfers: 1))
        
        availableRoomsSubject.on(.next(self))
    }
}

/** View model for a section in the availability table view. Contains title, the number of rows and the view models for the rows */
class AvailabilitySectionVM {
    var cells: [AvailabilityCellVM]
    var title: String = ""
    var cellIdentifier: String = ""
    var numberOfRows: Int {
        return cells.count
    }
    
    init(availabilities: [Availability], numberOfTransfers: Int) {
        cells = availabilities.map{(availability: Availability) -> AvailabilityCellVM in
            AvailabilityCellVM(roomAvailability: availability.roomAvailability)
        }
        
        if (numberOfTransfers == 0) {
            title = "Available rooms"
            cellIdentifier = "AvailabilityCell"
        } else if (numberOfTransfers == 1) {
            title = "With 1 transfer"
            cellIdentifier = "AvailabilityCellWithTransfer"
        }
    }
    
    init(roomAvailability: [RoomAvailability]) {
        title = "Available rooms"
        cellIdentifier = "AvailabilityCell"
        
        cells = roomAvailability.map{(roomAvailability: RoomAvailability) -> AvailabilityCellVM in
            AvailabilityCellVM(roomAvailability:roomAvailability)
        }
    }
}



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

struct AvailabilityViewModel {

    var availableRoomsSubject: PublishSubject<[RoomAvailability]> = PublishSubject()
    
    func rangeSelected(dateFrom: Date, dateTo: Date) {
        let period = Period(dateFrom: dateFrom, dateTo: dateTo)
        availableRoomsSubject.on(.next(DataService.getRoomAvailability(period: period)))
    }
    
}

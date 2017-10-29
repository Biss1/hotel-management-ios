//
//  Reservation.swift
//  HotelManagement
//
//  Created by Bisera Belkoska on 29.10.17.
//  Copyright © 2017 Bisera Belkoska. All rights reserved.
//

import Foundation
import RealmSwift

class Reservation: Object {
    dynamic var dateFrom: NSDate!
    dynamic var dateTo: NSDate!
    dynamic var dateReservation: NSDate!
    dynamic var room: Room!
    dynamic var guestName: NSString!
}

class Room: Object {
    dynamic var id = 0
    dynamic var roomNumber: String!
}

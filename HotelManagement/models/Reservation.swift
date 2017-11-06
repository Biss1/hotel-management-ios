//
//  Reservation.swift
//  HotelManagement
//
//  Created by Bisera Belkoska on 29.10.17.
//  Copyright © 2017 Bisera Belkoska. All rights reserved.
//

import Foundation
import RealmSwift

class Reservation: Object, Codable {
    dynamic var roomNumber: String!
    dynamic var dateFrom: Date!
    dynamic var dateTo: Date!
    dynamic var dateReservation: Date!
    dynamic var room: Room!
    dynamic var guestName: String!
    
}

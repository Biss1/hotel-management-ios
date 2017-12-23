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
    dynamic var id = 0
//    dynamic var guest: Guest?
    dynamic var numberOfPeople = 1
    dynamic var notes = ""
    var roomReservationsRLM = List<RoomReservation>()
    var roomReservations = [RoomReservation]()
    
    private enum CodingKeys: String, CodingKey {
        case id
//        case guest
        case numberOfPeople
        case notes
        case roomReservations
    }
    
    override static func ignoredProperties() -> [String] {
        return ["roomReservations"]
    }
}

class RoomReservation: Object, Codable {
    dynamic var id = 0
    dynamic var room: Room!
    dynamic var dateFrom: Date!
    dynamic var dateTo: Date!
    dynamic var dateReservation: Date!
}

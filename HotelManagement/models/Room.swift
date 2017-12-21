//
//  Room.swift
//  HotelManagement
//
//  Created by Bisera Belkoska on 06.11.17.
//  Copyright © 2017 Bisera Belkoska. All rights reserved.
//

import RealmSwift

class Room: Object, Codable {
    dynamic var id = 0
    dynamic var roomNumber: String!
    dynamic var numberOfGuests = 2
    
    convenience init(id: Int, roomNumber: String) {
        self.init()
        self.id = id
        self.roomNumber = roomNumber
    }
}


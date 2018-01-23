//
//  Guest.swift
//  GuestsList
//
//  Created by Jovana Trajcheska on 04.12.17.
//  Copyright © 2017 Jovana Trajcheska. All rights reserved.
//

import UIKit
import RealmSwift

class Guest: Codable {//Object,
    var id: Int
    var firstname: String
    var lastname: String
    var country: String
    var city: String
    var phone: String
    var email: String
    
    init(id: Int, firstname: String, lastname: String, country: String, city: String, phone: String, email:String)
    {
        self.id = id
        self.firstname = firstname
        self.lastname = lastname
        self.country = country
        self.city = city
        self.phone = phone
        self.email = email
    }
    
    func updateGuest(firstname: String, lastname: String, country: String, city: String, phone: String, email: String)
    {
        self.firstname = firstname
        self.lastname = lastname
        self.country = country
        self.city = city
        self.phone = phone
        self.email = email
        
    }
}

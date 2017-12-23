//
//  DataAPI.swift
//  HotelManagement
//
//  Created by Bisera Belkoska on 02.11.17.
//  Copyright © 2017 Bisera Belkoska. All rights reserved.
//

import Foundation
import RealmSwift

func getRealm() -> Realm {
    if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
        // Code only executes when tests are running
        return realmInMemory("HotelManagementTests")
    }
    return realmInMemory("HotelManagement")
}

class DataService {
    
    static func getRoomReservations(period: Period) -> Results<RoomReservation> {
        let realm = getRealm()
        let predicate = NSPredicate(format: "dateFrom =< %@ && dateTo >= %@", argumentArray: [period.dateTo, period.dateFrom])
        return realm.objects(RoomReservation.self).filter(predicate)
    }
    
    static func getAvailableRooms(period: Period) -> Results<Room> {
        let realm = getRealm()
        var predicate = NSPredicate(format: "dateFrom < %@ && dateTo > %@", argumentArray: [period.dateTo, period.dateFrom])
        let roomIds = realm.objects(RoomReservation.self).filter(predicate).map { $0.room.id }
        predicate = NSPredicate(format: "NOT (id IN %@)", Array(roomIds))
        return realm.objects(Room.self).filter(predicate)
    }
    
    static func getRooms() -> Results<Room> {
        let realm = getRealm()
        return realm.objects(Room.self)
    }
    
    static func getRoom(id: Int) -> Room? {
        let realm = getRealm()
        let predicate = NSPredicate(format: "id == %d", id)
        return realm.objects(Room.self).filter(predicate).first
    }
    
    var guests = [Guest(id: 1, firstname: "Jovana", lastname: "Trajcheska", country: "Macedonia", city:"Ohrid", phone: "078567345", email: "t_jovana@gmail.com"),
                  Guest(id: 2, firstname: "Marija", lastname: "Georgieva", country: "Macedonia", city: "Bitola", phone: "070546345", email: "mgeorg@gmail.com"),
                  Guest(id: 3, firstname: "Blagica", lastname: "Metuleva", country: "Macedonia", city: "Skopje", phone: "071345798", email: "mb@gmail.com")]
    
    let countries = [Country (image: #imageLiteral(resourceName: "macedonia"), name: "Macedonia"), Country (image: #imageLiteral(resourceName: "england"), name: "England"), Country (image: #imageLiteral(resourceName: "france"), name: "France"), Country (image: #imageLiteral(resourceName: "sweden"), name: "Sweden"), Country (image: #imageLiteral(resourceName: "usa"), name: "USA")]
    
    func numberOfGuestsinList() -> Int {
        return guests.count
    }
    func numberOfCountriesinList() -> Int {
        return countries.count
    }
    func addGuest(guest: Guest){
        guests.append(guest)
    }
    
    func updateGuest(guest: Guest) {
        let result = guests.contains(where: {$0.id == guest.id})
        if(result == true) {
            let guestwithid = guests.filter({$0.id == guest.id}).first
            guestwithid?.updateGuest(firstname: guest.firstname, lastname: guest.lastname, country: guest.country, city: guest.city, phone: guest.phone, email: guest.email)
        } else if(result == false){
            guests.append(guest)
        }
    }
    
    func deleteGuest(guest: Guest) {
        guests.remove(at: guest.id)
    }
}

struct Period {
    var dateFrom: Date!
    var dateTo: Date!
    var daysBetween: Int? {
        return NSCalendar.current.dateComponents([.day], from: dateFrom, to: dateTo).day
    }
    
    init(dateFrom: Date, dateTo:Date) {
        self.dateFrom = dateFrom
        self.dateTo = dateTo
    }
    
    init(dateFrom: Date) {
        self.dateFrom = dateFrom
        self.dateTo = Calendar.current.date(byAdding: .day, value: 1, to: dateFrom)!
    }
}

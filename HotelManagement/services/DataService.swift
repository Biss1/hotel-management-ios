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

struct DataService {
    
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

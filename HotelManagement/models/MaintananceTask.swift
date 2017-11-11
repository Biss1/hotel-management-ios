//
//  Task.swift
//  HotelManagement
//
//  Created by Bisera Belkoska on 06.11.17.
//  Copyright © 2017 Bisera Belkoska. All rights reserved.
//

import RealmSwift

class MaintananceTask: Object {
    dynamic var id = 0
    dynamic var title: String!
    var completed: Bool!
    dynamic var note: String!
}

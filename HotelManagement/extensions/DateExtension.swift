//
//  DateExtension.swift
//  HotelManagement
//
//  Created by Bisera Belkoska on 03.12.17.
//  Copyright © 2017 Bisera Belkoska. All rights reserved.
//

import Foundation

extension Date {
    func getNextDay() -> Date! {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
    
    func getPreviousDay() -> Date! {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
}

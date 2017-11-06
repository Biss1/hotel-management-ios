//
//  AvailabilityVC.swift
//  HotelManagement
//
//  Created by Bisera Belkoska on 03.11.17.
//  Copyright © 2017 Bisera Belkoska. All rights reserved.
//

import UIKit

class AvailabilityVC: UIViewController {

    let availabilityViewModel = AvailabilityViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "calendarVCSegue") {
            let calendarVC = segue.destination as? CalendarVC
            calendarVC?.availabilityViewModel = availabilityViewModel
        } else if (segue.identifier == "roomAvailabilitySegue") {
            let roomAvailabilityVC = segue.destination as? RoomAvailabilityTableVC
            roomAvailabilityVC?.availabilityViewModel = availabilityViewModel
        }
    }
}

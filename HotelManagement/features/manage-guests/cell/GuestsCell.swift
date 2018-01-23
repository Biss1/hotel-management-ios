//
//  GuestsTableViewCell.swift
//  GuestsList
//
//  Created by Jovana Trajcheska on 04.12.17.
//  Copyright © 2017 Jovana Trajcheska. All rights reserved.
//

import UIKit

class GuestsCell: UITableViewCell {
    
    @IBOutlet weak var firstlastnamelabel: UILabel!
    @IBOutlet weak var citycountrylabel: UILabel!
    
    func fillWith(guest: Guest){
        firstlastnamelabel.text = guest.firstname + " " + guest.lastname
        citycountrylabel.text = guest.city + "," + " " + guest.country
    }
}

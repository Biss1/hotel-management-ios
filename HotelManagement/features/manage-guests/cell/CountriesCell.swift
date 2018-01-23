//
//  CountriesCell.swift
//  GuestsList
//
//  Created by Jovana Trajcheska on 11.12.17.
//  Copyright © 2017 Jovana Trajcheska. All rights reserved.
//

import UIKit

class CountriesCell: UITableViewCell {

    @IBOutlet weak var countryImageView: UIImageView!
    @IBOutlet weak var countrynameLabel: UILabel!

    func initWith(country: Country){
        countryImageView.image = country.image
        countrynameLabel.text = country.name
    }
}

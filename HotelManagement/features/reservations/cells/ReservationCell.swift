//
//  ReservationCell.swift
//  HotelManagement
//
//  Created by Bisera Belkoska on 23.12.17.
//  Copyright © 2017 Bisera Belkoska. All rights reserved.
//

import UIKit

class ReservationCell: UITableViewCell {

    @IBOutlet weak var roomColor: UIView!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var guestLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func editReservation(_ sender: Any) {
    }
}

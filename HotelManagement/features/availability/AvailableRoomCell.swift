//
//  AvailableRoomCellTableViewCell.swift
//  HotelManagement
//
//  Created by Bisera Belkoska on 05.11.17.
//  Copyright © 2017 Bisera Belkoska. All rights reserved.
//

import UIKit

class AvailableRoomCell: UITableViewCell {
    @IBOutlet weak var roomName: UILabel!
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var colorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

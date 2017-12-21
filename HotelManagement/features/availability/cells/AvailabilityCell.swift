//
//  AvailabilityCell.swift
//  HotelManagement
//
//  Created by Bisera Belkoska on 11.11.17.
//  Copyright © 2017 Bisera Belkoska. All rights reserved.
//

import UIKit

class AvailabilityCell: UITableViewCell {

    var availabilityCellViewModel: AvailabilityCellViewModel!
    
    @IBOutlet weak var reserveButton: UIButton!
    @IBOutlet weak var firstRoomLabel: UILabel!
    @IBOutlet weak var firstPeriodLabel: UILabel!
    
    @IBOutlet weak var secondRoomLabel: UILabel?
    @IBOutlet weak var secondPeriodLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func initWithViewModel(viewModel: AvailabilityCellViewModel) {
        firstRoomLabel.text = viewModel.firstRoomText
        firstPeriodLabel.text = viewModel.firstPeriodText
        
        secondRoomLabel?.text = viewModel.secondRoomText
        secondPeriodLabel?.text = viewModel.secondPeriodText
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}



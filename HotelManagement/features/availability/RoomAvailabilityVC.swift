//
//  SecondViewController.swift
//  HotelManagement
//
//  Created by Bisera Belkoska on 31.08.17.
//  Copyright © 2017 Bisera Belkoska. All rights reserved.
//

import UIKit
import RealmSwift
import RxSwift
import RxRealm
import RxCocoa

class RoomAvailabilityTableVC: UIViewController {

    let disposeBag = DisposeBag()
    var availabilityViewModel: AvailabilityViewModel?
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var textFired: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        availabilityViewModel?.availableRoomsSubject.bind(to: tableView.rx.items(
            cellIdentifier: "AvailableRoomCell", cellType: AvailableRoomCell.self))
        { (row, element, cell) in
            cell.roomName.text = "\(element.room.roomNumber)"
            print("bind table \(element.room.roomNumber)")
            //            cell.textLabel?.text = "\(element) @ row \(row)"
            }.disposed(by: disposeBag)
    }
    
    @IBAction func change(_ sender: Any) {

    }

    
}

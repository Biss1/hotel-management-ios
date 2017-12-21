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

class RoomAvailabilityTableVC: UIViewController, UITableViewDataSource {

    let disposeBag = DisposeBag()
    var availabilityViewModel = AvailabilityViewModel()
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var textFired: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
//        availabilityViewModel?.availableRoomsSubject.bind(to: tableView.rx.items(
//            cellIdentifier: "AvailableRoomCell", cellType: AvailableRoomCell.self))
//        { (row, element, cell) in
////            cell.roomName.text = "\(element.roomAvailabilit[0])"
////            print("bind table \(element.room.roomNumber)")
//            //            cell.textLabel?.text = "\(element) @ row \(row)"
//            }.disposed(by: disposeBag)
        availabilityViewModel.availableRoomsSubject.subscribe{ event in //put weakself
            self.tableView.reloadData()
        }.disposed(by: disposeBag)
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100
    }
    
    @IBAction func change(_ sender: Any) {

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = availabilityViewModel.sections[indexPath.section];
        let cell = tableView.dequeueReusableCell(withIdentifier: section.cellIdentifier, for: indexPath) as! AvailabilityCell
        cell.initWithViewModel(viewModel: section.cells[indexPath.row])
        return cell
    }
    
    func numberOfSections(in: UITableView) -> Int {
        return availabilityViewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return availabilityViewModel.sections[numberOfRowsInSection].numberOfRows
    }
    
    func tableView(_ tableView:UITableView, titleForHeaderInSection: Int) -> String?{
        return availabilityViewModel.sections[titleForHeaderInSection].title
    }
}

//
//  FirstViewController.swift
//  HotelManagement
//
//  Created by Bisera Belkoska on 31.08.17.
//  Copyright © 2017 Bisera Belkoska. All rights reserved.
//

import Foundation
import Moya
import RealmSwift

class DayOverviewVC: UIViewController {
    
    var roomNumber: String!

    override func viewDidLoad() {
        super.viewDidLoad()
//        downloadRepositories()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func dateChanged(_ sender: UIDatePicker) {
        let componenets = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
        if let day = componenets.day, let month = componenets.month, let year = componenets.year {
            print("\(day) \(month) \(year)")
        }
    }
    
    fileprivate func showAlert(_ title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(ok)
        present(alertController, animated: true, completion: nil)
    }

    @IBAction func add(_ sender: Any) {
        addReservation()
    }
    func addReservation() {
        do {
            if (roomNumber == "6") {
                roomNumber = "7"
            }else { roomNumber = "6" }
            let res = Reservation()
//            res.roomNumber = roomNumber;
            print("Room number " + roomNumber)
            let realm = try! Realm()
            try! realm.write {
                realm.add(res)
            }
        } catch {
            let printableError = error as CustomStringConvertible
            print(printableError)
        }
    }
    
    func downloadRepositories() {
        reservationsProvider.request(.getAllReservations) { result in
            do {
                let response = try result.dematerialize()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(formatter) //posible custom date formatter
                
                let list = try decoder.decode([Reservation].self, from: response.data)
                print(list)
                let realm = try! Realm()
                try! realm.write {
                    realm.add(list)
                }
                
                let reservations = realm.objects(Reservation.self)
                print(reservations.count)
            } catch {
                let printableError = error as CustomStringConvertible
                print(printableError)
            }
        }
    }
}



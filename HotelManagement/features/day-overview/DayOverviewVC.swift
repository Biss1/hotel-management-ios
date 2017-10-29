//
//  FirstViewController.swift
//  HotelManagement
//
//  Created by Bisera Belkoska on 31.08.17.
//  Copyright © 2017 Bisera Belkoska. All rights reserved.
//

import Foundation
import Moya

class DayOverviewVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        downloadRepositories()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func showAlert(_ title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(ok)
        present(alertController, animated: true, completion: nil)
    }

    func downloadRepositories() {
        reservationsProvider.request(.getAllReservations) { result in
            do {
                let response = try result.dematerialize()
//                let reservations = try response.mapArray(Reservation.self)
//
            } catch {
                let printableError = error as CustomStringConvertible
            }
        }
    }
}



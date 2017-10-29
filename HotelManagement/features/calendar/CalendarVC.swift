//
//  CalendarVC.swift
//  HotelManagement
//
//  Created by Bisera Belkoska on 14.10.17.
//  Copyright © 2017 Bisera Belkoska. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarVC: UIViewController {
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    
    let formatter = DateFormatter()
    var firstDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView.allowsMultipleSelection  = true
        calendarView.isRangeSelectionUsed = true
    }
}

extension CalendarVC: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource
{
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyy MM dd";
        formatter.timeZone = Calendar.current.timeZone;
        formatter.locale = Calendar.current.locale;
        
        let startDate = formatter.date(from: "2017 01 01")
        let endDate = formatter.date(from: "2018 01 01")
        
        let parameters = ConfigurationParameters(startDate: startDate!, endDate: endDate!)
        return parameters
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCell
        cell.dateLabel.text = cellState.text
        return cell;
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        if firstDate != nil {
            calendar.selectDates(from: firstDate!, to: date,  triggerSelectionDelegate: false, keepSelectionIfMultiSelectionAllowed: true)
            firstDate = nil
        } else {
//            calendar.deselectAllDates()
            firstDate = date
        }
        for d in calendar.selectedDates {
            handleSelection(cell: cell, cellState: calendar.cellStatus(for: d)!)
        }
    }
    
    func handleSelection(cell: JTAppleCell?, cellState: CellState) {
        let myCustomCell = cellState.cell() as? CalendarCell // You created the cell view if you followed the tutorial
        switch cellState.selectedPosition() {
        case .full, .left, .right:
            myCustomCell?.selectedView.isHidden = false
            myCustomCell?.selectedView.backgroundColor = UIColor.yellow // Or you can put what ever you like for your rounded corners, and your stand-alone selected cell
        case .middle:
            myCustomCell?.selectedView.isHidden = false
            myCustomCell?.selectedView.backgroundColor = UIColor.blue // Or what ever you want for your dates that land in the middle
        default:
            myCustomCell?.selectedView.isHidden = true
            myCustomCell?.selectedView.backgroundColor = nil // Have no selection when a cell is not selected
        }
    }

    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleSelection(cell: cell, cellState: cellState)
    }

    func calendar(_ calendar: JTAppleCalendarView, willDisplayCell cell: JTAppleCell, date: Date, cellState: CellState) {
        handleSelection(cell: cell, cellState: cellState)
    }
}

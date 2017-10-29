//
//  CalendarFSVC.swift
//  HotelManagement
//
//  Created by Bisera Belkoska on 14.10.17.
//  Copyright © 2017 Bisera Belkoska. All rights reserved.
//

import UIKit
import FSCalendar

class CalendarVC: UIViewController {
    fileprivate let gregorian = Calendar(identifier: .gregorian)
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    @IBOutlet weak var calendar: FSCalendar!
    
    fileprivate weak var eventLabel: UILabel!
    var firstDate: Date?
    var lastDate: Date?
    var hasRange = false
    
    // MARK:- Life cycle
    
     func viewdd() {
        
//        let view = UIView(frame: UIScreen.main.bounds)
//        view.backgroundColor = UIColor.groupTableViewBackground
//        self.view = view
//
        calendar.calendarHeaderView.backgroundColor = UIColor(red: 69/255.0, green: 129/255.0, blue: 142/255.0, alpha: 1)
        calendar.calendarWeekdayView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        calendar.appearance.eventSelectionColor = UIColor.white
        calendar.appearance.eventOffset = CGPoint(x: 0, y: -7)
//        calendar.today = nil // Hide the today circle
        calendar.register(CalendarCell.self, forCellReuseIdentifier: "cell")
                calendar.clipsToBounds = true // Remove top/bottom line
//        calendar.calendarHeaderView = FSCalendarHeaderView.init();
        calendar.swipeToChooseGesture.isEnabled = true // Swipe-To-Choose
        
        let scopeGesture = UIPanGestureRecognizer(target: calendar, action: #selector(calendar.handleScopeGesture(_:)));
        calendar.addGestureRecognizer(scopeGesture)
        
        
        let label = UILabel(frame: CGRect(x: 0, y: calendar.frame.maxY + 10, width: self.view.frame.size.width, height: 50))
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        self.view.addSubview(label)
        self.eventLabel = label
        
//        let attributedText = NSMutableAttributedString(string: "")
//        let attatchment = NSTextAttachment()
//        attatchment.image = UIImage(named: "icon_cat")!
//        attatchment.bounds = CGRect(x: 0, y: -3, width: attatchment.image!.size.width, height: attatchment.image!.size.height)
//        attributedText.append(NSAttributedString(attachment: attatchment))
//        attributedText.append(NSAttributedString(string: "  Hey Daily Event  "))
//        attributedText.append(NSAttributedString(attachment: attatchment))
//        self.eventLabel.attributedText = attributedText
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "FSCalendar"
        // Uncomment this to perform an 'initial-week-scope'
        // self.calendar.scope = FSCalendarScopeWeek;
        self.viewdd()
        let dates = [
            self.gregorian.date(byAdding: .day, value: -1, to: Date()),
            Date(),
            self.gregorian.date(byAdding: .day, value: 1, to: Date())
        ]
        dates.forEach { (date) in
            self.calendar.select(date, scrollToDate: false)
        }
        // For UITest
        self.calendar.accessibilityIdentifier = "calendar"
        
    }
}

extension CalendarVC : FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance
{
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position)
        return cell
    }
    
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
        self.configure(cell: cell, for: date, at: position)
    }
    
    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
        if self.gregorian.isDateInToday(date) {
            return "今"
        }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return 2
    }
    
    // MARK:- FSCalendarDelegate
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendar.frame.size.height = bounds.height
        self.eventLabel.frame.origin.y = calendar.frame.maxY + 10
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition)   -> Bool {
        return monthPosition == .current
    }
    
    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return monthPosition == .current
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did select date \(self.formatter.string(from: date))")
        let cal = Calendar.current
        if !hasRange && firstDate != nil {
            if firstDate! >= date {
                calendar.deselect(firstDate!)
                firstDate = date
                calendar.select(date)
                self.configureVisibleCells()
                return
            }
            var pomDate = firstDate
            while pomDate! <= date {
                calendar.select(pomDate)
                pomDate = cal.date(byAdding: .day, value: 1, to: pomDate!)
            }
            hasRange = true;
            lastDate = date;
        } else if hasRange && firstDate != nil && lastDate != nil {
            var pomDate = firstDate
            while pomDate! <= lastDate! {
                calendar.deselect(pomDate!)
                pomDate = cal.date(byAdding: .day, value: 1, to: pomDate!)
            }
            firstDate = date
            hasRange = false
        } else {
            firstDate = date
        }
        self.configureVisibleCells()
    }
    
//    func calendar(_ calendar: FSCalendar, didDeselect date: Date) {
//        print("did deselect date \(self.formatter.string(from: date))")
//        self.configureVisibleCells()
//    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        if self.gregorian.isDateInToday(date) {
            return [UIColor.orange]
        }
        return [appearance.eventDefaultColor]
    }
    
    // MARK: - Private functions
    
    private func configureVisibleCells() {
        calendar.visibleCells().forEach { (cell) in
            let date = calendar.date(for: cell)
            let position = calendar.monthPosition(for: cell)
            self.configure(cell: cell, for: date!, at: position)
        }
    }
    
    private func configure(cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
        
        let diyCell = (cell as! CalendarCell)
        // Custom today circle
//        diyCell.circleImageView.isHidden = !self.gregorian.isDateInToday(date)
        // Configure selection layer
        if position == .current {
            var selectionType = SelectionType.none
            
            if calendar.selectedDates.contains(date) {
                let previousDate = self.gregorian.date(byAdding: .day, value: -1, to: date)!
                let nextDate = self.gregorian.date(byAdding: .day, value: 1, to: date)!
                if calendar.selectedDates.contains(date) {
                    if calendar.selectedDates.contains(previousDate) && calendar.selectedDates.contains(nextDate) {
                        selectionType = .middle
                    }
                    else if calendar.selectedDates.contains(previousDate) && calendar.selectedDates.contains(date) {
                        selectionType = .rightBorder
                    }
                    else if calendar.selectedDates.contains(nextDate) {
                        selectionType = .leftBorder
                    }
                    else {
                        selectionType = .single
                    }
                }
            }
            else {
                selectionType = .none
            }
            if selectionType == .none {
                diyCell.selectionLayer.isHidden = true
                return
            }
            diyCell.selectionLayer.isHidden = false
            diyCell.selectionType = selectionType
            
        } else {
//            diyCell.circleImageView.isHidden = true
            diyCell.selectionLayer.isHidden = true
        }
    }
    
}

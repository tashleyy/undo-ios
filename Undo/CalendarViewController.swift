//
//  CalendarViewController.swift
//  Undo
//
//  Created by Tiffany Tjahjadi on 4/21/17.
//  Copyright © 2017 Tiffany Tjahjadi. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarViewController: UIViewController, UINavigationBarDelegate {
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var monthLabel: UILabel!

    let formatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.delegate = self
        setupCalendarView()
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.topAttached
    }
    
    func setupCalendarView() {
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        calendarView.visibleDates { visibleDates in
            let date = visibleDates.monthDates.first!.date
            self.formatter.dateFormat = "MMMM"
            self.monthLabel.text = self.formatter.string(from: date)
        }
    }
    
    func handleCellTextColor(cell: JTAppleCell?, cellState: CellState) {
        guard let validCell = cell as? CalendarAppleCell else { return }
        if cellState.dateBelongsTo == .thisMonth {
            validCell.dateLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        } else {
            validCell.dateLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        }
    }

    @IBAction func togglePressed(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }

    @IBAction func addPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let nc: UINavigationController = storyboard.instantiateViewController(withIdentifier: "navAddVC") as! UINavigationController
        present(nc, animated: true, completion: nil)
    }
    
    @IBAction func prevPressed(_ sender: Any) {
        calendarView.scrollToSegment(.previous)
    }
    
    @IBAction func nextPressed(_ sender: Any) {
        calendarView.scrollToSegment(.next)
    }
}

extension CalendarViewController: JTAppleCalendarViewDataSource {
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyyy/MM/dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "2017/01/01")
        let endDate = formatter.date(from: "2017/12/31")
        let parameters = ConfigurationParameters(startDate: startDate!, endDate: endDate!)
        return parameters
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "calendarCell", for: indexPath) as! CalendarAppleCell
        cell.dateLabel.text = cellState.text
        handleCellTextColor(cell: cell, cellState: cellState)
        if cellState.isSelected {
            cell.selectedView.isHidden = false
        } else {
            cell.selectedView.isHidden = true
        }
        return cell
    }
}

extension CalendarViewController: JTAppleCalendarViewDelegate {
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        guard let validCell = cell as? CalendarAppleCell else { return }
        validCell.selectedView.isHidden = false
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        guard let validCell = cell as? CalendarAppleCell else { return }
        validCell.selectedView.isHidden = true
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        let date = visibleDates.monthDates.first!.date
        formatter.dateFormat = "MMMM"
        monthLabel.text = formatter.string(from: date)
    }
}

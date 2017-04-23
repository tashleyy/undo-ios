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
    var todos: [[[Todo]]] = Array(repeating: Array(repeating: [], count: 31), count: 12)
    static var lastViewedDate: Date?

    let formatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.delegate = self
        setupCalendarView()
        TodoManager.sharedInstance.subscribe { self.reloadData() }
        reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        CalendarViewController.lastViewedDate = calendarView.visibleDates().monthDates.first!.date
    }
    
    func reloadData() {
        let data = TodoManager.sharedInstance.get()
        for todo in data {
            self.formatter.dateFormat = "MM"
            let month = Int(formatter.string(from: todo.dueDate))
            self.formatter.dateFormat = "dd"
            let date = Int(formatter.string(from: todo.dueDate))
            todos[month!-1][date!-1].append(todo)
        }
        let date = CalendarViewController.lastViewedDate ?? Date.init(timeIntervalSinceNow: 0)
        calendarView.reloadData(with: date, animation: false, completionHandler: nil)
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.topAttached
    }
    
    func setupCalendarView() {
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        let date = CalendarViewController.lastViewedDate ?? Date.init(timeIntervalSinceNow: 0)
        formatter.dateFormat = "MMMM"
        monthLabel.text = formatter.string(from: date)
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
        self.formatter.dateFormat = "MM"
        let monthInt = Int(formatter.string(from: date))
        self.formatter.dateFormat = "dd"
        let dateInt = Int(formatter.string(from: date))
        if todos[monthInt!-1][dateInt!-1].count != 0 && cellState.dateBelongsTo == .thisMonth {
            cell.todoView.isHidden = false
        } else {
            cell.todoView.isHidden = true
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

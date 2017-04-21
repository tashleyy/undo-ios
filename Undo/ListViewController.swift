//
//  ListViewController.swift
//  Undo
//
//  Created by Tiffany Tjahjadi on 4/21/17.
//  Copyright © 2017 Tiffany Tjahjadi. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UINavigationBarDelegate, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    var todos: [Todo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        todos = TodoManager.get()
        navBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.topAttached
    }

    @IBAction func togglePressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let cvc: CalendarViewController = storyboard.instantiateViewController(withIdentifier: "calendarVC") as! CalendarViewController
        present(cvc, animated: false, completion: nil)
    }

    @IBAction func addPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let avc: AddViewController = storyboard.instantiateViewController(withIdentifier: "addVC") as! AddViewController
        present(avc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "listCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: cellId)
        }
        cell?.textLabel?.text = todos[indexPath.row].name
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E MMM dd, yyyy"
        cell?.detailTextLabel?.text = dateFormatter.string(from: todos[indexPath.row].dueDate)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let evc: EditViewController = storyboard.instantiateViewController(withIdentifier: "editVC") as! EditViewController
        present(evc, animated: true, completion: nil)
    }
}

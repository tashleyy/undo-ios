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
        navBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        TodoManager.sharedInstance.subscribe { self.reloadData() }
        reloadData()
    }
    
    func reloadData() {
        todos = TodoManager.sharedInstance.get()
        tableView.reloadData()
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.topAttached
    }

    @IBAction func togglePressed(_ sender: Any) {
        (parent as? UITabBarController)?.selectedIndex = 1
    }

    @IBAction func addPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let nc: UINavigationController = storyboard.instantiateViewController(withIdentifier: "navAddVC") as! UINavigationController
        present(nc, animated: true, completion: nil)
    }
    
    @IBAction func settingsPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let svc: SettingsViewController = storyboard.instantiateViewController(withIdentifier: "settingsVC") as! SettingsViewController
        present(svc, animated: true, completion: nil)
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
        let nc: UINavigationController = storyboard.instantiateViewController(withIdentifier: "navEditVC") as! UINavigationController
        let evc: EditViewController = nc.childViewControllers.first! as! EditViewController
        evc.index = indexPath.row
        evc.initialName = todos[indexPath.row].name
        evc.initialDueDate = todos[indexPath.row].dueDate
        present(nc, animated: true, completion: nil)
    }
}

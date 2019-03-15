//
//  NoteTableViewController.swift
//  CoreDataExample
//
//  Created by Phan Dinh Van on 3/15/19.
//  Copyright © 2019 Phan Dinh Van. All rights reserved.
//

import UIKit
import CoreData

class NoteTableViewController: UITableViewController {
    
    var entries = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
        print(entries)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entrycell", for: indexPath) as! EntryTableViewCell
        cell.lblEntryContent.text = entries[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let btnEdit = UIContextualAction(style: .normal, title: "Edit") { (action, view, handler) in
            
        }
        btnEdit.backgroundColor = UIColor.blue
        let btnDelete = UIContextualAction(style: .normal, title: "Delete") { (action, view, handler) in
            
        }
        btnDelete.backgroundColor = UIColor.green
        return UISwipeActionsConfiguration(actions: [btnEdit, btnDelete])
    }
    
    func loadData() {
        entries.removeAll()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Entry")
        request.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(request) as [AnyObject]
            for r in results {
                entries.append(r.value(forKey: "content") as! String)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        } catch {
            let alert = UIAlertController(title: "Notification", message: "Occur an error while fetching!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

    }

}

//
//  ViewController.swift
//  Todey
//
//  Created by Billy Hoang on 2018-10-18.
//  Copyright © 2018 Billy Hoang. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

//    var itemArray = ["Buy milk", "Work out", "Study"]
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let item1 = Item()
        item1.title = "buy milk"
        itemArray.append(item1)
        
        let item2 = Item()
        item2.title = "laundry"
        itemArray.append(item2)
        
        let item3 = Item()
        item3.title = "homework"
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
            itemArray = items
        }
        
    }
    
    //MARK - Tableview Datasource Methods
    
    // Returns the actual (re-usable) table cell with all the data that is should display for a given row index
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("cellForRowAt called")
        
        // Create/re-use a reusable cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        // Set the cell's text
        cell.textLabel?.text = item.title
        
        // Set the cell's checkmark if the item is done
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK - TableView delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = itemArray[indexPath.row]
        
        cell.done = !cell.done
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Todoey Item", message: "", preferredStyle: .alert)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once the user clicks the add item button button on the UIAlert
            guard let userInput = textField.text else {
                return
            }
            print(userInput)
            
            let newItem = Item()
            newItem.title = userInput
            self.itemArray.append(newItem)
            
//            do {
//                let encodedItemArray = try NSKeyedArchiver.archivedData(withRootObject: self.itemArray, requiringSecureCoding: false)
//                self.defaults.set(encodedItemArray, forKey: "ToDoListArray")
//            } catch {
//                print("Could not encode itemsArray into userDefaults")
//            }
            
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}


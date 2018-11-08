//
//  ViewController.swift
//  Todoey
//
//  Created by Activelink on 04/11/2018.
//  Copyright © 2018 Ann Adaya. All rights reserved.
//

import UIKit

    class TodoListViewController: UITableViewController {

        let defaults = UserDefaults.standard
        
        var itemArray = [Item]()

        override func viewDidLoad() {
            super.viewDidLoad()
            
        let newItem = Item()
            newItem.title = "Find Mike"
            itemArray.append(newItem)
            
        let newItem2 = Item()
            newItem.title = "Buy Eggs"
            itemArray.append(newItem2)
            
        let newItem3 = Item()
            newItem.title = "Destroyyyy Demogorgon"
            itemArray.append(newItem3)
            
            if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
                itemArray = items
            }
            
    }
        
    //Mark - Tableview Datasource Methods
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return itemArray.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
            
        let item = itemArray[indexPath.row]
            
        cell.textLabel?.text = item.title
        
/*short code from the if else statement below -- using ternary operator
    value = condition ? valueIfTrue : valueIfFalse
            
      cell.accessoryType = item.done == true ? .checkmark : .none
             
        we can make it shorter as well
 */
            
    //this says if the cell.accessoryType is true then set it to check mark -- and if its not true then set it to .none
    cell.accessoryType = item.done ? .checkmark : .none
            
//            if item.done == true {
//                cell.accessoryType = .checkmark
//            } else {
//                cell.accessoryType = .none
//            }

            return cell
        }
        
        
//Mark - TableView Delegate Methods
        

        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   
//this single replaces our if statement code below - saying if its true make it false, if its false make it true - using this ! operator basically reversing what its used to be.
            
            itemArray[indexPath.row].done = !itemArray[indexPath.row].done
            
//             if itemArray[indexPath.row].done == false {
//                itemArray[indexPath.row].done = true
//             } else {
//                itemArray[indexPath.row].done = false
//             }
            
    //what this really does is it forces the tableview to call its data source methods again so that it reloads the data, that means to be inside
            tableView.reloadData()
            
            tableView.deselectRow(at: indexPath, animated: true)
            

        }
        
        //MARK: Add New Items
        
        @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
            
            var textField = UITextField()
            
            let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
            

            let action = UIAlertAction(title: "Add Item", style: .default) {
                 (action) in
                
                let newItem = Item()
                newItem.title = textField.text!
                
                //then here now we can append but using newItem
                
                self.itemArray.append(newItem)
                
                self.defaults.set(self.itemArray, forKey:"TodoListArray")
                
                self.tableView.reloadData()
                
            }
            alert.addTextField { (alertTextField) in
                alertTextField.placeholder = "Create new item"
                textField = alertTextField

            }
            
            
            alert.addAction(action)

            present(alert, animated: true, completion: nil)
    }

}


















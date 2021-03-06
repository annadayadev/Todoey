//
//  ViewController.swift
//  Todoey
//
//  Created by Activelink on 04/11/2018.
//  Copyright © 2018 Ann Adaya. All rights reserved.
//


//Migrate Error -- to resolve this, you need to press and hold the app on the home until it tickles and you can choose to remove the app and back to xcode and build again.

//For our SearchBar --- Every single time we've declared off you viecontrollerapp as a delegate of something we also have to make an IB outlet for our search bar and then inside viewdidload say something like searchbar.delegate = self ---- same procedure, adding the protocol in the class declaration and also setting the outlet's delegate as self.

import UIKit
import RealmSwift

    class TodoListViewController: UITableViewController {
        
        var todoItems : Results<Item>?
        let realm = try! Realm()
 
        var selectedCategory : Category? {
            didSet {
                //when we do call loaditems were certain that we've already got a value for our selected category and were not calling it before we actually have a value which might crash our app
                
                //var items : Results<Item>?
                
                loadItems()
    
            }
        }
   
        override func viewDidLoad() {
            super.viewDidLoad()
        
       //were just getting the path to where the data is being stored for our current app
            print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
            
    //search bar
            
            //this is optional, you can do this on code or alternatively you can simply hit control drog and point to the little yellow icon at the header which represents 
          //  searchBar.delegate = self
            
            //loadItems()
    }
        
//Mark - Tableview Datasource Methods
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return todoItems?.count ?? 1
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)

            if let item = todoItems?[indexPath.row] {
                
                cell.textLabel?.text = item.title
                
                cell.accessoryType = item.done ? .checkmark : .none
                
            } else {
                cell.textLabel?.text = "No Items Added"
            }

            return cell
        }
        
        
     // Sequence of deleting, first is we have to call context delete first to remove this and its managed object from our context before we try to remove it from item array because we're using the item array here to try and grab that object -- so now if we run an app with this new order then you can see that when we try to delete something our app works as expected
        
        
//Mark - TableView Delegate Methods
        
        //No matter how you decide to update your NSManageObject, you will still have to always have to call context.save -- that's because we're doing all of our changes, all of our creating, updating, reading and destroying inside our temporary context -- and only once we're happy with those changes that we call context.save and commits those changes to our permanent container.

        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            if let item = todoItems?[indexPath.row] {
                //if this is not nil
                do {
                    try realm.write {
                //this is for deleting instead of checking
                        //realm.delete(item)
                        item.done = !item.done
                    }
            } catch {
                print("Error saving done status, \(error)")
            }
        }
            
            tableView.reloadData()
            
    /* To delete items from our context -- all we need to do is call context.delete and then specify the item that we want removed but that's not enough -- as with everything using coredata and trying to do crud on it we also have to also save the context and commit the current status to our persistent container. Basically whenever you need to change the data inside the persistent store you always need to call context.save to commit those changes.
 
        Now when you're reading or as we've done inside loadItems we dont call save items or context or save here because we dont need to change the persistent container-- and instead we're just fetching it and looking at the current version.
    */
            
    //for deleting the current selected row, but then this is just the temporary area and unless we have that context and we commit those changes to our persistent container then this line would have done nothing at all.
            
        //    context.delete(itemArray[indexPath.row])
   
   //when we reload the tableview we were able to refresh the latest items
            
       //     itemArray.remove(at: indexPath.row)
     

            
           // itemArray[indexPath.row].done = !todoItems[indexPath.row].done
            
          //  saveItems()
            
            tableView.deselectRow(at: indexPath, animated: true)
            
    }
        
 //MARK: Add New Items
        
        @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
            
            var textField = UITextField()
            
            let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
                //what will happen once the user clicks the Add Item button on our UIAlert
                
                if let currentCategory = self.selectedCategory {
                    do {
                        try self.realm.write {
                            let newItem = Item()
                            newItem.title = textField.text!
                            newItem.dateCreated = Date()
                            currentCategory.items.append(newItem)
                        }
                    } catch {
                        print("Error saving new items, \(error)")
                    }
                }
                
                self.tableView.reloadData()
                
            }
            
            alert.addTextField { (alertTextField) in
                alertTextField.placeholder = "Create new item"
                textField = alertTextField

            }
            
            
            alert.addAction(action)

            present(alert, animated: true, completion: nil)
    }
        
//MARK - Model Manipulation Methods
        
    func loadItems() {

        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

            tableView.reloadData()
    }
}

//This is our TodoListViewController EXTENSION - where we are extending the functionality by adding search bar -- so this is a good point for us to query our database and try to get back the results that the user is searching for.



//MARK: - Search Bar Methods -- Command + K to open text on simulator
extension TodoListViewController: UISearchBarDelegate {

     func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        
    //when the search bar is clicked, we're going to filter
        
        //means update todoitems to equal to todoitems filtered by this predicate
//        todoItems = todoItems?.filter("title CONTAINS[cd] %@, searchBar.text!").sorted(byKeyPath: "title", ascending: true)
        
        //sorted by date created
        todoItems = todoItems?.filter("title CONTAINS[cd] %@, searchBar.text!").sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()

    }


//*** So here, what should happen if we dismissed the searchbar
//this method is not going to trigger because the text has not changed and its only when the text is changed

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

            if searchBar.text?.count == 0 {
                loadItems()

    //dispatchqueue is that manager who assigns these projects to different threads

                DispatchQueue.main.async {
                    //keyboard cursor disappears
                        searchBar.resignFirstResponder()

                }

            }

        }


}


//So what happened was were creating a new request, then we modify it with our query and our sort descriptor, and then we pass that request into our load items function on the (loadItems(with request: NSFetchRequest<Item>), and then we perform that request by saying context.fetch so we can now delete this do catch block -- on the extension todolistviewcontroller, and we can also delete tableView.reloadData() because its already inisde loaditems


















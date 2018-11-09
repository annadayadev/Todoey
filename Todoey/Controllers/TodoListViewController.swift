//
//  ViewController.swift
//  Todoey
//
//  Created by Activelink on 04/11/2018.
//  Copyright © 2018 Ann Adaya. All rights reserved.
//


/* Thead Signal : SIGABRT ERROR MEANS THE APP HAS CRASH
    A non property attempting to se a nonproperty list object using user default.
 
    Do not use userdefaults because its very limited to string, its very inefficient, dont use default for anything other than that basically user defaults --

*/
import UIKit

    class TodoListViewController: UITableViewController {
        
        
        var itemArray = [Item]()
        
   //we move this datafilepath up here so it can be access by our codes on the add item --- now this is a global constant.
        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
        
  //so instead of using userdefaults, we're going to create our own list at the location of our data file path.
        //let defaults = UserDefaults.standard
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            //we'll create a file path to the documents folder -- filemanager, which is the object that provides an interface to the filesystem ----and default returns the shared file manager object for the process-- singleton contains a whole bunch of urls and they're organized by directory and domain mask. So the search path directory we need to tap into is the --- document directory. But be careful here, we are looking for DOCUMENT DIRECTORY and not documentation directory they are very different.
        
            
            print(dataFilePath)
            
            loadItems()
    }
        
    //Mark - Tableview Datasource Methods
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return itemArray.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)

//so this item now is now the item that we're currently trying to set up for the cell on the (cellForRowAt indexPath:) above
        let item = itemArray[indexPath.row]
            
        cell.textLabel?.text = item.title
        
/*short code from the if else statement below -- using ternary operator
    value = condition ? valueIfTrue : valueIfFalse
            
      cell.accessoryType = item.done == true ? .checkmark : .none
             
        we can make it shorter as well
 */
            
//this says if the cell.accessoryType is true then set it to check mark -- and if its not true then set it to .none
  
// this says, set the cells accessory type depending on whether the item .done is true, if its true then set it to checkmark, if not then set it to .none
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
            

// if its true it becomes false, if its false it becomes true - booleans can only have 2 results, true/false, so its reversing its current result
            
    itemArray[indexPath.row].done = !itemArray[indexPath.row].done
            
            
//             if itemArray[indexPath.row].done == false {
//                itemArray[indexPath.row].done = true
//             } else {
//                itemArray[indexPath.row].done = false
//             }
           
//we can now delete the reloadData below code since it already exists inside our saveitems.
            
        saveItems()
            
    //what this really does is it forces the tableview to call its data source methods again so that it reloads the data, that means to be inside
          //  tableView.reloadData()
            
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
                
    
  //after removing the userdefaults because we will be creating our own plist, the first thing we need to change is this line below, where we set our item array for the key todolistarray into our userdefaults. And because our itemArray is an array of our custom item object then this line fails -- and this is when our app crashes.
                //self.defaults.set(self.itemArray, forKey:"TodoListArray")
    
    //so now we are going to create an encoder --- and the code is going to be a new object of the type property list encoder and we're going to intialize it.
                //encoder process - let encoder equals propertylist, encode the data then try and write the data to that data file path -- and if theres an error print error and then reload the data. Instead of copying these codes, its a good time to think about creating a safe data method-- lets go ahead and create a new function called saveItem
                
       /*         let encoder = PropertyListEncoder()
              //which will encode our data namely our item array into a propertylist, so we're going to use our encoder and were going to use the method in code and the value that were going to encode is our item array. But once we hit enter we might stumble with some error -- one is that the encode method can throw an error. so we know what we do, and that is to incorporate a do block, try and catch --- and finally we need to mark this method with a try and because we are inside a closure -- i.e the part that gets triggered once the user presses the add item button then we have to mark all our properties with a self.
                do {
                    let data = try encoder.encode(self.itemArray)
                    //now once we have coded our data, the next step is to write the data to our data file path, and this is also a method that can throw errors, so we have to marked it with a try also -- so writing the data to a location and the location is ofcourse going to be a data file path that we indicated at the top and we need to move it outside or on the very top so it will be global. And again, we need to mark this a self because we are again inside a closure.
                    try data.write(to: self.dataFilePath!)
                } catch {
                    print("Error encoding item array, \(error)")
                }
                
                //the next thing we have to do here is to go to our datamodel and we have to mark our class as conforming to the protocols -- Encodable
                
                
                self.tableView.reloadData()
 */
                
                self.saveItems()
                
            }
            
            alert.addTextField { (alertTextField) in
                alertTextField.placeholder = "Create new item"
                textField = alertTextField

            }
            
            
            alert.addAction(action)

            present(alert, animated: true, completion: nil)
    }
        
    //MARK - Model Manipulation Methods
        
        //inside this function - were going to copy all of the let encoder code - so now because we're no longer inside a closure we can get rid of these self method, and we can also simply call saveItems() from the lines where we remove these codes --- both when we added new item using the alert controller but also when we toggle the check mark
    func saveItems(){
            let encoder = PropertyListEncoder()

            do {
                let data = try encoder.encode(itemArray)
                try data.write(to: dataFilePath!)
            } catch {
                print("Error encoding item array, \(error)")
            }
            
            //the next thing we have to do here is to go to our datamodel and we have to mark our class as conforming to the protocols -- Encodable
            
            
            self.tableView.reloadData()
        }
        

        
    func loadItems() {
            //this again a method that can throw error - so we're going to makr it with a try questionmark which will turn the result of this method into an optional so then we will use optional binding to unwrap that safely. So now, just as above we created an object that was an encoder using the property list encoder in order to decode items, we have to create a decoder and its a propertylistdecoder
            if let data = try? Data(contentsOf: dataFilePath!) {
                let decoder = PropertyListDecoder()
                
                //now that we've got our decoder, were going to see our array up here -- itemarray which contains an array of items
                do {
                    itemArray = try decoder.decode([Item].self, from: data)
                } catch {
                    print("Error decoding item array, \(error)")
                }
        }

}

}

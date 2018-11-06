//
//  ViewController.swift
//  Todoey
//
//  Created by Activelink on 04/11/2018.
//  Copyright © 2018 Ann Adaya. All rights reserved.
//

import UIKit

// we changed this from UIViewController into UITableViewController because we deleted that page. and we will also edit the file name for this file so it will make sense -- and we will name it TodoListViewController.swift
    class TodoListViewController: UITableViewController {
        
        let itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
        
        //Mark - Tableview Datasource Methods
        
//the first data source method that we're going to add is the number of rows so if we just start writing table view then you can see that we've got this whole big selection of different things that we might want to include, and this code is expecting an output in a return statement that will be the number of rows
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return itemArray.count
        }
        
//UITableView (Local Variable) - this local variable her ecomes from this method as one of the parameters -- now in this case it doesnt really matter which of the two because they're both going to refer to the same thing.
        
//UITableView (Global Variable) - is what we get by subclassing this tableviewcontroller its the same as if we created an IB outlet from the tableview on the main storyboard and call it tableview here --- its just the default name that's given to the tableview outlet
        
//asks the data source for a cell to insert in a particular location of the table view
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           //here we will create a cell that is going to be a reusable cell.
            //let cell = UITableViewCell(style:.default,reuseIdentifier:"ToDoItemCell")
            
            //the identifier is ofcourse the identifier we gave to our prototype--- todoitemcell
            let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)

            //now here we're going to set the text label-- this is the label that's in every single cell and we;re going to set its text property and we're going to set it to equal the items in our item array,and at the index path that we're currently populating .row -- so the current row of the current index path.
            cell.textLabel?.text = itemArray[indexPath.row]
            
            //and finally, we're going to return our cell as this method expects an output and that cell that's been created using our reuse prototype cell--- and that has been populated with text of the current row is now returned to the tableview and displayed as a row.
            return cell
        }
        
        /* make sure to review topics about tableview and where we did the animated explanations of table use in flashchat module because tableview is part of the bread and butter of any ios developer.
        
         We were using as much help as we can get from XCODE and using a lot of template code that they can provide for us by subclassing this to do list viewcontroller as UI Table you control. We didnt need to create our IB Outlet we already have access to this thing called tableview and also we didnt need to say tableview.delegate equals self or type od data source equals self---- and that's all because of this one single powerful subclassing that we've done here. Don't forget to review tableviews
        */
        
        //So to create this up the first thing that we need is some tableview delegate methods.
        
        //Mark - TableView Delegate Methods
        
        //start typing tableview and see all the suggest ---- and the one that we want is the didSelectRowAt indexPath --- tellsthe delegate that the specified row is now selected.
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           
            //so this is gonna print the number into the debug console when we select one of the cells
            // this is the code if we want to print out the index number of the rows--- print(indexPath.row)
            
            //the next thing we wanna do is instead of printing out the row i want to printout the corresponding item in the item array --- ["Find Mike", "Buy Eggos", "Destroy Demogorgon"] --- and now this is working perfectly returning on the console the text inside the rows.
            
                print(itemArray[indexPath.row])
            
            /*the next thing we want to do is to add a checkmark next to the cells which we have selected -- and in order to do that we're going to use what we call an accessory.
             on the leftside panel under Todoey Scene > todo list viewcontroller > table view > todoitemcell > content view
             
             so here lets select the tableview.cell of row at indexpath and this is grabbing a reference to the cell that is at a particular indexpath. Now which indexpath that we're going to specify will obviously the one that's currently selected? --- ofcourse indexpath.
             */
            //we will comment this one out because this code works but without deselecting/uncheck the rows.
               // tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            
            //now that its working, the next thing is how can we remove the checkmark once its deselected or clicked again? and the solution will be by using if statement
            
            if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
                tableView.cellForRow(at: indexPath)?.accessoryType = .none
            } else {
                tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            }
            
            // now its working we can check and uncheck from the above code
            
            //another things is that we dont want the highlight showing on the selected row, and so we will remove that one, and to do that ----
            
                tableView.deselectRow(at: indexPath, animated: true)
            

            
            
        }

}



















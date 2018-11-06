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
        
        //we changed this from let into var because we want this to be mutable, again let is fixed but here we needed our newly added item to be included in the array
        var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]

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
        
        //MARK: Add New Items -- here we can add code to determine what should happen when the user presses that add button --- and what we want to happen here is for a pop up or a UI alert controller to show when i press the add button and to have a textfield in that UI alert so that i can write a quick to do list item and then append it to the end of our item array --- so now lets create a brandnew alert.

        @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
            
            var textField = UITextField()
            
            let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
            
            //and then we're going to create an action - and this is going to be the UI alert action and this action is going to have a title, style and a handler -- the add item is going to be the button that you're going to press once your done with writing your new todolist.
            let action = UIAlertAction(title: "Add Item", style: .default) {
                 (action) in
                
                //what will happen once the user clicks the add item button on our UIalert -- this is the place where we make something happen after the user clicked the add item button, so nothing will happen when this block of code is empty
                //print("Success!")
                //print(textField.text)
       
                //we now able to get any value that is inside the textfield because of this print statement above. It is very important to understand where these local variables are available and how you can use them to store data and read data. So now we need to fix this up, and instead of the print statement will put some action in it based on what functions we really need -- and that is to add whatever text the user inserted into our array and append into this array at the end -- but before we ca append an item to our item array, we first need to change this array from being immutable because its a constant mutable by getting rid of that list and changing it to all.
                
                //we need to force unwrap it because the text property of a textfield is never going to equal nil even if its empty its going to be set to an empty string.And we can add some more checking code in here to maybe prevent the action from going forwards if the textfield is empty or add some more vaidation code. but for now we're just going to say that if the user entered nothing will just simply have an empty cell -- we can say if textfield.text is nil, then simply append the string new item. And because we are inside closure, we have to specify self to tell the complier explicitly where this item array exists i.eg in the current class.
                self.itemArray.append(textField.text!)
                
                //now up to this point, even if everything has setup all the codes are good to go, there's one issue that we will be encountering, what happen is that whatever the user inputs will still not show in our UI, however it is already added in our array, so what happen is that, we need to reload it for it to display, and so we added this code below.
                
                self.tableView.reloadData()
                
        }
            alert.addTextField { (alertTextField) in
                alertTextField.placeholder = "Create new item"
                textField = alertTextField
                /*were going to print whatever text is in the alertTextField --- when we click the addbutton on the print success at the top there we can write some code that specifies what should happen once the user clicks the add item button on the alert but the alert textfield is created as a local variable only inside this closure (inside the "in") --- so what should we do to pass this into the above code -- inside the Add Item button? --- so essentially, what we need is a local variable inside this IB Action --- do inside the scope of the curly braces of addButtonPressed, that's accessible to all of these other completion handlers.
                
                    So currently, we've got this alert textfield that has the scope of just this closure ("in") -- and if we want to change its very very limited scope i.e being available just inside here in the alert.addTextField -- then we have to create a local variable within the scope of this addbuttonpressed, so anywhere that's outside of one of these closures.
                 
                    So what we can do is we can create a textfield up here at the top-- var textField = UITextField() -- which is going to be a UItextfield and we're going to initialize it to an empty UItextfield -- now this textfield has the scope of the entire buttonpressed IB action and is going to be accessible on all the scope within buttonpressed.
                 
                 So now what we can do is we can set this textField with a wider scope to equal the alert textfield that has a slightly narrowest scope because its only available inside here -- alert.addTextField --- textField = alertTextField. --- and this doesnt exist outside of this scope. so we're extending the scope of that alert textfield to this addbuttonpressed.
                 
                 So the sequence of events matters a great deal.
                */
                
        //and we can solve that timing problem by simply storing a reference to that alert textfield inside a local variable thats available to everybody that's inside to the addButtonPressed -- and this textField is what we're going to print inside here so we can say print textfield.text instead of  this print statement below.
                //print(alertTextField.text)
                //prints to see when this clouse gets triggered
               // print("Now")
                
                
            }
            
            
            alert.addAction(action)
            
            //so here we finally need to show our alert -- so we simply say present, and its a viewcontroller that we want to present and the viewcontroller to present -- and the viewcontroller is ofcourse the alert.
            present(alert, animated: true, completion: nil)
    }

}


















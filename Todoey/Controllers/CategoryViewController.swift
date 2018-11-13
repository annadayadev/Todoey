//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Activelink on 11/11/2018.
//  Copyright © 2018 Ann Adaya. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
//code smell/bad smell, indicates possibly bad code or deeper problem but not always -- this code is a perfect way of creating a new realm.
    let realm = try! Realm()
    
    //var categories = [Category]()
    
//inorder to use result data type we will change our datatype here-- results is an auto-updating container type in realm returned from object queries.
    var categories : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
//    print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        loadCategories()
        
    }
    
    
    
//MARK: - TableView Datasource Methods -- so we can display all the categories that are inside our persistent container
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    //if its not nil then return category.count, if it is nil then just return one -- this syntax in Swift is called Nil Coalescing Operator -- if its nil then this operator will say, use this value (1) instead
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            //reusable cells
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
           // let category = categories[indexPath.row]
        
            cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added yet"
        
            return cell
        
        
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        saveCategories()
//
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//
   
    
// This is for the Segue -- changing screens/pages
//MARK: - TableView Delegate Methods -- refers to what should happen when we click on one of the cells inside the category table.
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        
        }
    
    //prepare for segue, because this is going to be triggered just before we perform that segue
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            //constant that's going to store a reference to the destination
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
        
            destinationVC.selectedCategory = categories?[indexPath.row]
            
        }
    }
    
    
    
//MARK: - Data Manipulation Methods -- namely save data and load data so that we can use CRUD
    
    func save(category: Category){
        
            do {
                try realm.write {
                    realm.add(category)
                }
            } catch {
                print("Error saving context \(error)")
            }
        
            tableView.reloadData()
        
        }
    
    
    func loadCategories() {
        
        //we say, look inside the realm and fetch all of the objects that belong to the category data type
        
         categories = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
    
    
//MARK: - Add New Categories --- so setup the addButtonPressed IB Action in order to add new categories using our categories entity and the

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message:"", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) {
                (action) in
              
        //what should happen when the user clicks that add button?
                let newCategory = Category()
                newCategory.name = textField.text!
            
        //since our result data type as we found out earlier is an auto updating container -- we dont necessarily need to append things anymore -- because it will simply auto-update.
               // self.categories.append(newCategory)
                
                self.save(category: newCategory)
                
            }
        
        
            alert.addAction(action)
        
            alert.addTextField { (field) in
                textField.placeholder = "Add a new category"
                textField = field
            }
        
            present(alert, animated: true, completion: nil)
        
        
        }
    
}



































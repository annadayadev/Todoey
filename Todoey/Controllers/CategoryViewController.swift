//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Activelink on 11/11/2018.
//  Copyright © 2018 Ann Adaya. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categories = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        
//    print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        loadCategories()
        
    }
    
    
    
//MARK: - TableView Datasource Methods -- so we can display all the categories that are inside our persistent container
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            //reusable cells
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
           // let category = categories[indexPath.row]
        
            cell.textLabel?.text = categories[indexPath.row].name
        
            return cell
        
        
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        saveCategories()
//
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//
    
//MARK: - TableView Delegate Methods -- refers to what should happen when we click on one of the cells inside the category table.
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        
        }
    //prepare for segue, because this is going to be triggered just before we perform that segue
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            //constant that's going to store a reference to the destination
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
        
            destinationVC.selectedCategory = categories[indexPath.row]
            
        }
    }
    
    
    
//MARK: - Data Manipulation Methods -- namely save data and load data so that we can use CRUD
    
    func saveCategories(){
        
            do {
                try context.save()
            } catch {
                print("Error saving context \(error)")
            }
        
            tableView.reloadData()
        
        }
    
//    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
//
//            do {
//                categories = try context.fetch(request)
//            } catch {
//                print("Error fetching data from context \(error)")
//            }
//
//            tableView.reloadData()
//        }
    
    func loadCategories() {
        
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            categories = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
    }
    
    
    
//MARK: - Add New Categories --- so setup the addButtonPressed IB Action in order to add new categories using our categories entity and the

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
            var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Category", message:"", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) {
                (action) in
              
        //what should happen when the user clicks that add button?
                let newCategory = Category(context: self.context)
                newCategory.name = textField.text!
                
                self.categories.append(newCategory)
                
                self.saveCategories()
                
            }
        
        
            alert.addAction(action)
        
            alert.addTextField { (field) in
                textField.placeholder = "Create new category"
                textField = field
            }
        
            present(alert, animated: true, completion: nil)
        
        
        }
    
}


































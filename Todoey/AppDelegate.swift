//
//  AppDelegate.swift
//  Todoey
//
//  Created by Activelink on 04/11/2018.
//  Copyright © 2018 Ann Adaya. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {

        self.saveContext()
    }
    
    // MARK: - Core Data stack
 
 //lazy variables are when we create a variable that we declare as lazy that it only gets loaded up with a value at the time point when its needed -- i.e when you try to use this thing called persistentcontainer that is when all of this code is going to run and its going have a value set -- the lazy variable gets a memory benefit -- so you're only occupying the memory when its needed rather than having everything set up beforehand.
    lazy var persistentContainer: NSPersistentContainer = {

        
        //make sure that the name should be the same from the file we just created namely DataModel
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {

                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}



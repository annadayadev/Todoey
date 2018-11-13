//
//  AppDelegate.swift
//  Todoey
//
//  Created by Activelink on 04/11/2018.
//  Copyright © 2018 Ann Adaya. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
      //to locate our realm database
       //print(Realm.Configuration.defaultConfiguration.fileURL)
        
        
   //here were going to create our brandnew realm -- realm is a different persistence containers,but it can provide a throw error
        
    //realm allows us to use object oriented programming persist objects
 
//after adding our Data.swift, we can now create a new piece of data that is going to be an object of the data class and we can set its properties
        

        do {
            _ = try Realm()
            
        } catch {
            print("Error initialising realm, \(error)")
        }
        
        return true
    }



}


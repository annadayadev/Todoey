//
//  Category.swift
//  Todoey
//
//  Created by Activelink on 12/11/2018.
//  Copyright © 2018 Ann Adaya. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    //dont forget these 2 keywords to make sure that we are tagging realm, and now these lines are a complete reprsentation of our item entity using properties instead of attributes.
    @objc dynamic var name : String = ""
    
    //so now we have a forward relationship, each category having a list of items
    let items = List<Item>()
  
    
/*
//creating relationships
1- forward relationship, List - is the container type in Realm used to define to-many relationships
     
    let items = List<Item>()
     //going to hold an a list of item objects and were going to initialize it as an empty list
    
    //this is one way of declaring array
   
    let array = [Int]()
     //shortcut of array 123++ and () means we want to initialized it or [Int] = [1,2,3] or Array<Int> = [1,2,3] and if you want to declare an empty array of integers--- Array<Int>()
    
    
2 - Inverse relationship - is not define automatically. Instead, you actually have to go inside the item class and create it yourself. So after declaring it here as a parent, we will add the code on the Item.swift
    
    linkingobjects are auto updating containers that represent 0 or more objects that are linked to its owning model object through a property relationship-- simply defining the inverse relationship of items. Each category has a one to many relationship with a list of items and each item has an inverse relationship to a category called the parent category --- and we have to initialize linking objects with a type and a property name.
     
        var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
*/
    
}





















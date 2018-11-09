//
//  Item.swift
//  Todoey
//
//  Created by Activelink on 08/11/2018.
//  Copyright © 2018 Ann Adaya. All rights reserved.
//

import Foundation

// Encodable - a type that can encode itself to an external representation --- this means that the item type is now able to encode itself a plist or into a JSON. And for a class to be able to be incredible all of its properties must have standard data types -- things like strings, booleans, arrays, dictionaries and they all work but not if you have a custom class.

//class Item: Encodable, Decodable { -- codable means both

class Item: Codable {
    var title: String = ""
    // in our todolist item by default, all items will start off as being not done -- so we'll set that as false.
    var done: Bool = false
}






















































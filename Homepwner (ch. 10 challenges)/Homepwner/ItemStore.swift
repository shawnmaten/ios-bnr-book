//
//  ItemStore.swift
//  Homepwner
//
//  Created by Shawn Aten on 8/26/18.
//  Copyright © 2018 Shawn Aten. All rights reserved.
//

import UIKit

class ItemStore {
    
    var allItems = [Item]()
    
    var cheapItems: [Item] {
        get {
            return allItems.filter({ (item) -> Bool in
                return item.valueInDollars <= 50
            })
        }
    }
    
    var expensiveItems: [Item] {
        get {
            return allItems.filter({ (item) -> Bool in
                return item.valueInDollars > 50
            })
        }
    }
    
    init() {
        for _ in 0..<20 {
            createItem()
        }
    }
 
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        return newItem
    }
}

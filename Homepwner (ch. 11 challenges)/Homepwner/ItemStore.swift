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
 
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        return newItem
    }
    
    func removeItem(_ item: Item) {
        if let index = allItems.index(of: item) {
            allItems.remove(at: index)
        }
    }
    
    func moveItem(from fromIndex: Int, to toIndex: Int) {
        if (fromIndex == toIndex) {
            return
        }
        
        // Get reference to object being moved so you can insert it
        let movedItem = allItems[fromIndex]
        
        // Remove item from array
        allItems.remove(at: fromIndex)
        
        // Insert item in array at new location
        allItems.insert(movedItem, at: toIndex)
    }
}

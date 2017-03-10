//
//  ItemStore.swift
//  Homepwner
//
//  Created by Mischa Beumer on 3/10/17.
//  Copyright © 2017 msbbeumer. All rights reserved.
//

import UIKit

class ItemStore {
    var cheapItems = [Item]()
    var expensiveItems = [Item]()
    let sectionTitles = ["Cheap Items", "Expensive Items"]

    @discardableResult func createItem() -> Item {
        let newItem = (Item(random: true))
        
        if newItem.valueInDollars <= 50 {
            cheapItems.append(newItem)
        } else {
            expensiveItems.append(newItem)
        }
        
        return newItem
    }
    
    func removeItem(_ item: Item) {
        if let index = cheapItems.index(of: item) {
            cheapItems.remove(at: index)
        }
        
        if let index = expensiveItems.index(of: item) {
            expensiveItems.remove(at: index)
        }
    }
    
    func moveItem(originSection fromSection: Int, from fromIndex: Int,destinationSection toSection: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        // Get reference to object being moved so you can reinsert it
        if fromSection == 0 {
            let movedItem = cheapItems[fromIndex]
            
            // remove item from Array
            cheapItems.remove(at: fromIndex)
            
            // Insert item in array at new location
            if toSection == 0 {
                cheapItems.insert(movedItem, at: toIndex)
            } else {
                expensiveItems.insert(movedItem, at: toIndex)
            }
            
        } else {
            let movedItem = expensiveItems[fromIndex]
            
            // remove item from Array
            expensiveItems.remove(at: fromIndex)
            
            // Insert item in array at new location
            if toSection == 1 {
                expensiveItems.insert(movedItem, at: toIndex)
            } else {
                cheapItems.insert(movedItem, at: toIndex)
            }
        }
        
        
        
    }
}

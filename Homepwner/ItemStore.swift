//
//  ItemStore.swift
//  Homepwner
//
//  Created by Mischa Beumer on 3/10/17.
//  Copyright © 2017 msbbeumer. All rights reserved.
//

import UIKit

class ItemStore {
    // MARK: - Properties
    var allItems = [Item]()
    
    // MARK: - Archive management
    //Item Archive URL
    let itemArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("items.archive")
    }()
    
    func saveChanges() -> Bool {
        print("Saving items to: \(itemArchiveURL.path)")
        return NSKeyedArchiver.archiveRootObject(allItems, toFile: itemArchiveURL.path)
    }
    
    init() {
        if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: itemArchiveURL.path) as? [Item] { allItems = archivedItems }
    }
    
    // MARK: - ItemStore methods
    @discardableResult func createItem() -> Item {
        let newItem = (Item(random: false))
        
        allItems.append(newItem)
        
        return newItem
    }
    
    func removeItem(_ item: Item) {
        if let index = allItems.index(of: item) {
            allItems.remove(at: index)
        }
    }
    
    func moveItem(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        // Get reference to object being moved so you can reinsert it
        let movedItem = allItems[fromIndex]
        
        // remove item from Array
        allItems.remove(at: fromIndex)
        
        // Insert item in array at new location
        allItems.insert(movedItem, at: toIndex)
    }
}

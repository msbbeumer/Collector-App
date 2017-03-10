//
//  ItemStore.swift
//  Homepwner
//
//  Created by Mischa Beumer on 3/10/17.
//  Copyright © 2017 msbbeumer. All rights reserved.
//

import UIKit

class ItemStore {
    var allItems = [Item]()
    
    @discardableResult func createItem() -> Item {
        let newItem = (Item(random: true))
        
        allItems.append(newItem)
        
        return newItem
    }
}

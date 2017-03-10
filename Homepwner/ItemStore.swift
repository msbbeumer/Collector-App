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
    
    init () {
        for _ in 0..<5 {
            createItem()
        }
    }
}

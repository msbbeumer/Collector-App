//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by Mischa Beumer on 3/10/17.
//  Copyright © 2017 msbbeumer. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    var itemStore: ItemStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the height of the status bar
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        // Format top table view inset equal to the height of the status bar
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
        // Set the row heights equal to 60 points
        tableView.rowHeight = 60
        tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "images-1"))
    }
    
    // Get the number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return itemStore.sectionTitles.count
    }
    
    // Set the section titles
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return itemStore.sectionTitles[section]
    }
    
    // Set the section footers
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        switch section {
        case 0:
            return nil
        default:
            return "No more items!"
        }
    }
    
    // Get the number of rows in each section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return itemStore.cheapItems.count
        default:
            return itemStore.expensiveItems.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get a new or recycled cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        var item = Item()
        
        // Set the text on the cell with the description of the item that is at the nth index of items, where n = row this cell will apear in on the tableview
        switch indexPath.section {
        case 0:
            item = itemStore.cheapItems[indexPath.row]
        default:
            item = itemStore.expensiveItems[indexPath.row]
        }
        
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        cell.textLabel?.font = cell.textLabel?.font.withSize(20)
        cell.detailTextLabel?.font = cell.textLabel?.font.withSize(20)
        
        return cell
    }
}

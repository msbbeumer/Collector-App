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
    
    @IBAction func addNewItem(_ sender: UIButton) {
        
        // Create a new item and add it to the store
        let newItem = itemStore.createItem()
        
        // Figure out where that item is in the array
        if let index = itemStore.cheapItems.index(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)
            
            // Insert this new row into the table
            tableView.insertRows(at: [indexPath], with: .automatic)
        } else if let index = itemStore.expensiveItems.index(of: newItem) {
            let indexPath = IndexPath(row: index, section: 1)
            
            // Insert this new row into the table
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    @IBAction func toggleEditingMode(_ sender: UIButton) {
        
        if isEditing {
            sender.setTitle("Edit", for: .normal)
            
            setEditing(false, animated: true)
        } else {
            sender.setTitle("Done", for: .normal)
            
            setEditing(true, animated: true)
        }
    }
    
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
        tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "iPhone 7 Plus background"))
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
    /* override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        switch section {
        case 0:
            return nil
        default:
            return "That's all the functionality we have to offer!"
        }
    } */
    
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // If the table view is asking to commit a delete command...
        var item = Item()
        if editingStyle == .delete {
            if  indexPath.section == 0 {
                item = itemStore.cheapItems[indexPath.row]
            } else {
                item = itemStore.expensiveItems[indexPath.row]
            }
            // Create the actionSheet UIAlertController to warn about deleting the row
            let title = "Delte \(item.name)?"
            let message = "Are you sure you want to remove this item?"
            let ac = UIAlertController(title: title,
                                       message: message,
                                       preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            
            let deletAction = UIAlertAction(title: "Remove", style: .destructive, handler: { (action) -> Void in
                
                // Remove the item from the store
                self.itemStore.removeItem(item)
                
                // Also remove that row from the table view with an animation
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                
            })
            ac.addAction(deletAction)
            
            // Present the alert controller
            present(ac, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // Update the model
        itemStore.moveItem(originSection: sourceIndexPath.section, from: sourceIndexPath.row, destinationSection: destinationIndexPath.section, to: destinationIndexPath.row)
    }
}

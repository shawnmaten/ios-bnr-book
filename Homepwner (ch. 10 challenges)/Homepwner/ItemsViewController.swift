//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by Shawn Aten on 8/26/18.
//  Copyright © 2018 Shawn Aten. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    var itemStore: ItemStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the height of the status bar
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
        let backgroundImage = UIImageView(image: #imageLiteral(resourceName: "list_background"))
        tableView.backgroundView = backgroundImage
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Cheap 🐥"
        case 1:
            return "Expensive 🤑"
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return itemStore.cheapItems.count
        case 1:
            return itemStore.expensiveItems.count + 1
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == tableView.numberOfSections - 1 {
            if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
                return tableView.dequeueReusableCell(withIdentifier: "UITableViewCellLast", for: indexPath)
            }
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        // Set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // will appear in on the tableview
        let items = indexPath.section == 0 ? itemStore.cheapItems : itemStore.expensiveItems
        let item = items[indexPath.row]
        
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        
        return cell
    }
    
}

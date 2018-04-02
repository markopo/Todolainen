//
//  ViewController.swift
//  Todolainen
//
//  Created by Marko Poikkimäki on 2018-03-26.
//  Copyright © 2018 Marko Poikkimäki. All rights reserved.
//

import UIKit

class TodolainenVC: UITableViewController {
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for index in 1...30 {
            
            let item = Item()
            item.title = "Bajskorv #\(index)"
            item.done = false
            itemArray.append(item)
            
        }
        
        /**
        if let itemArr =  defaults.array(forKey: "ItemArray") as? [Item] {
          //  print("storage: \(itemArr.count)")
            itemArray = itemArr
        }
        */
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row];
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done == true ? .checkmark : .none
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
           // let item = itemArray[indexPath.row]
          //  print("ITEM: \(item)")
        
            itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
            tableView.reloadData()
            tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    @IBAction func addBarButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        alert.addTextField { (txtField) in
            txtField.placeholder = "Add new item"
            textField = txtField
        }
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let theText = textField.text!.trimmingCharacters(in: NSCharacterSet.whitespaces)
            
            if !theText.isEmpty {
                let newItem = Item()
                newItem.title = theText
                
                self.itemArray.append(newItem)
                self.defaults.set(self.itemArray, forKey: "ItemArray")
                self.tableView.reloadData()
            }
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    


}


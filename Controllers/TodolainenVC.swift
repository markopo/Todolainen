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
    
     let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("DATAFILE: \(dataFilePath!)")
        
        loadItems()

        /***
        for index in 1...30 {
            
            let item = Item()
            item.title = "Bajskorv #\(index)"
            item.done = false
            itemArray.append(item)
            
        }
         */
        
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
        
            // TOGGLE
            itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
            saveItems()
        
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
               
                self.saveItems()
                
            }
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems() {
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadItems() {
    
        if let data = try? Data(contentsOf: dataFilePath!) {
            
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("ERROR IN DECODING ITEMS: \(error)")
            }
        }
     
    }


}


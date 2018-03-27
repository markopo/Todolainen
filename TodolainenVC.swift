//
//  ViewController.swift
//  Todolainen
//
//  Created by Marko Poikkimäki on 2018-03-26.
//  Copyright © 2018 Marko Poikkimäki. All rights reserved.
//

import UIKit

class TodolainenVC: UITableViewController {
    
    var itemArray = ["Bajsa", "Äta mat", "Dricka öl", "Programmera", "Gymma", "Sova", "Basta"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
           // let item = itemArray[indexPath.row]
          //  print("ITEM: \(item)")
        
            let isChecked = tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
            tableView.cellForRow(at: indexPath)?.accessoryType = !isChecked ? .checkmark : .none
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
                self.itemArray.append(theText)
                self.tableView.reloadData()
            }
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    


}


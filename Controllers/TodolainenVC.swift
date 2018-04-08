//
//  ViewController.swift
//  Todolainen
//
//  Created by Marko Poikkimäki on 2018-03-26.
//  Copyright © 2018 Marko Poikkimäki. All rights reserved.
//

import UIKit
import CoreData

class TodolainenVC: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var itemArray = [Item]()
    
     let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
       // print("DATAFILE: \(dataFilePath!)")
        
       loadItems()
        
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
                let newItem = Item(context: self.context)
                newItem.title = theText
                newItem.done = false
                self.itemArray.append(newItem)
                self.saveItems()
            }
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems() {
        do {
            try context.save()
        } catch {
            print("Error save Items, \(error)")
        }
        tableView.reloadData()
    }
    
    func loadItems() {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do {
          itemArray = try context.fetch(request)
        }
        catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    func deleteItem(index: Int) {
        let selectedItem = itemArray[index]
        context.delete(selectedItem)
        itemArray.remove(at: index)
        saveItems()
    }
    
}


// MARK: - Search bar methods
extension TodolainenVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let searchText = searchBar.text?.lowercased() ?? "";
        
        if !searchText.isEmpty {
            itemArray = itemArray.filter { $0.title!.lowercased().contains(searchText) }
        }
        else {
            loadItems()
        }
        
         tableView.reloadData()
    }
    
    
}


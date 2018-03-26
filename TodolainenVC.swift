//
//  ViewController.swift
//  Todolainen
//
//  Created by Marko Poikkimäki on 2018-03-26.
//  Copyright © 2018 Marko Poikkimäki. All rights reserved.
//

import UIKit

class TodolainenVC: UITableViewController {
    
    let itemArray = ["Bajsa", "Äta mat", "Dricka öl"]

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



}


//
//  ViewController.swift
//  myScheduling
//
//  Created by Ahmad Mustafa on 2/18/18.
//  Copyright © 2018 Ahmad Mustafa. All rights reserved.
//

import UIKit

class MySchedlingListViewController: UITableViewController {

    var itemCell = ["Study Swift","go to university","Con't in clean app"]
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemCell.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {//well this will add the Strings to each line in the table row
        let cell = tableView.dequeueReusableCell(withIdentifier: "theItemCell", for: indexPath)
        cell.textLabel?.text = itemCell[indexPath.row]
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemCell[indexPath.row])
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
       
    }
    
    @IBAction func uiAddItem(_ sender: UIBarButtonItem) {
        
        var mainText = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
           // print(mainText.text)
            self.itemCell.append(mainText.text!)
            self.tableView.reloadData()
        }
        alert.addTextField { (addNewText) in
            addNewText.placeholder = "Create new Item"
            mainText = addNewText
        }
        alert.addAction(action)
        present(alert,animated: true, completion: nil)
    }
    

}




//
//  ViewController.swift
//  myScheduling
//
//  Created by Ahmad Mustafa on 2/18/18.
//  Copyright © 2018 Ahmad Mustafa. All rights reserved.
//

import UIKit

class MySchedlingListViewController: UITableViewController {

    let itemCell = ["Study Swift","go to university","Con't in clean app"]
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
    


}


//
//  CategoreyViewController.swift
//  myScheduling
//
//  Created by Ahmad Mustafa on 5/11/18.
//  Copyright © 2018 Ahmad Mustafa. All rights reserved.
//

import UIKit
import CoreData

class CategoreyViewController: UITableViewController {

    var itemCell = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItem()
        
    }
    //Mark: - TableView DataSoruse
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemCell.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cells = tableView.dequeueReusableCell(withIdentifier: "CategoreyCells", for: indexPath)
        
        let item = itemCell[indexPath.row]
        
        cells.textLabel?.text = item.name
        
        return cells
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItem", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! MySchedlingListViewController
        
       if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = itemCell[indexPath.row]
        }
    }
   
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var tableText = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newItem = Category(context: self.context)
            newItem.name = tableText.text!
            
            self.itemCell.append(newItem)
            
            self.saveItem()
        }
        alert.addTextField { (addNewItem) in
            addNewItem.placeholder = "ADD NEW ITEM"
            
            tableText = addNewItem
        }
        
        alert.addAction(action)
        present(alert,animated: true, completion: nil)
        
    }
    
    func saveItem(){
        do{
            try context.save()
            
        }catch{
            print("Error save \(error)")
        }
        tableView.reloadData()
    }
    
    func loadItem(with request : NSFetchRequest<Category> = Category.fetchRequest()){
        do{
            itemCell = try context.fetch(request)
        }catch{
            print("Error load item \(error)")
        }
        tableView.reloadData()
    }
    
    //Mark: - TableView Delegate Methods
    
    
}

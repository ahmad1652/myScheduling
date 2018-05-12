//
//  ViewController.swift
//  myScheduling
//
//  Created by Ahmad Mustafa on 2/18/18.
//  Copyright © 2018 Ahmad Mustafa. All rights reserved.
//
// to sync data we have to use SandBox it share the docment Data to another file or when we update or change the device

/* ///////////////////////////
 Notice the context is area to control data
 CRUD e.g create , read , context.save().....
 but presistent data is to save data premently
 
 with is external paramter
 *////////////////////////////

import UIKit
import CoreData

class MySchedlingListViewController: UITableViewController {

    var itemCell = [Item]()
    
    var selectedCategory : Category? {
        didSet{
            loadItem()
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    // to declare the context whice do the save data when we need it
    //so to get context from Appdelegate we use that method
    //and presistentContainer store the data temperory
    
    //this method will create file and this file contain array and inside the array theres a dictenry in smart sort way
    
    
    
//    let defults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        //let request : NSFetchRequest<Item> = Item.fetchRequest()
        loadItem()
        
//        if let item = defults.array(forKey: "theItemCell") as? [Item]{
//            itemCell = item
//        }     

        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemCell.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {//well this will add the Strings to each line in the table row
        let cell = tableView.dequeueReusableCell(withIdentifier: "theItemCell", for: indexPath)
        
        let item = itemCell[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        //we will change this method cause we want to associted the data each one alone
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemCell[indexPath.row])
     
//        context.delete(itemCell[indexPath.row])
//        itemCell.remove(at: indexPath.row)
        
        itemCell[indexPath.row].done = !itemCell[indexPath.row].done
        saveItem()
        
      
        tableView.deselectRow(at: indexPath, animated: true)
        
       
    }
    
    @IBAction func uiAddItem(_ sender: UIBarButtonItem) {
        
        var mainText = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
           // print(mainText.text)
            
            let newItems = Item(context: self.context)
            newItems.title = mainText.text!
            newItems.done = false //we have to add done cause 1. its not optional 2. to save item
            newItems.parentGategory = self.selectedCategory
            self.itemCell.append(newItems)
//          self.defults.set(self.itemCell, forKey: "theItemCell")//this for save the data when we back again
            self.saveItem()
            
            
        }
        alert.addTextField { (addNewText) in
            addNewText.placeholder = "Create new Item"
            mainText = addNewText
        }
        alert.addAction(action)
        present(alert,animated: true, completion: nil)
    }
    
    //Mark - Send data to the SQLite
    func saveItem(){
        
        do{
          try context.save()
        }catch {
            print("Error save Context \(error)")
        }
        tableView.reloadData()
    }
    
    //Mark - Get data from SQLite
    func loadItem(with request : NSFetchRequest<Item> = Item.fetchRequest(), predicate:NSPredicate? = nil){
        let categoryPredicate = NSPredicate(format: "parentGategory.name MATCHES %@", selectedCategory!.name!)
        
       if let addtionalPredicate = predicate {//if it's not null
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, addtionalPredicate])
       }else{
        request.predicate = categoryPredicate
        }
//        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate , predicate])
//
//        request.predicate = compoundPredicate
        
        do{
            itemCell = try context.fetch(request)//find all data
        }catch{
            print("error in fetching data \(error)")
        }
        tableView.reloadData()

    }

}

//==================================================
//Mark - When we make extension we make a better class with include inheratence
extension MySchedlingListViewController : UISearchBarDelegate{
    //Mark - Find the key word
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
         request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        //Mark - there's website to NSPredicate e.g CONTAINS[cd] and aditions more
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        //Mark - Sort the result of serach (Must be in array)
        
        loadItem(with: request )
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0 {
            
            loadItem()
            
            DispatchQueue.main.async {//manages the execution of work items. Each work item submitted to a queue is processed on a pool of threads managed by the system.
                
                searchBar.resignFirstResponder()//restore to the origanl mainTableBoared(elinquish its status as first responder in its window)
            }
        }
    }
    
}




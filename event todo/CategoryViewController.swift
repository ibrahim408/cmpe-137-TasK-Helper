//
//  CategoryViewController.swift
//  event todo
//
//  Created by ibrahim ibrahim on 5/7/17.
//  Copyright © 2017 IBMibrahim. All rights reserved.
//

import UIKit

class CategoryViewController:  UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var categorysCoreDate : [Category] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        getEventData()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let category = categorysCoreDate[indexPath.row]
        

    
        cell.textLabel?.text = "\(category.title!)"
            
  
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categorysCoreDate.count
    }
    
    
    func getEventData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
            categorysCoreDate = try context.fetch(Category.fetchRequest())
        }catch{
            print("did not work")
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        
        if editingStyle == .delete{
            let category = categorysCoreDate[indexPath.row]
            
            context.delete(category)
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do{
                categorysCoreDate = try context.fetch(Category.fetchRequest())
            }catch{
                print("did not work")
            }
        }
        
        tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "EventViewsSeque", sender: categorysCoreDate[indexPath.row].title)
    }
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let test = segue.destination as! EventViewController
        
        test.navigationItem.title = sender as? String
    }
 */

    
}


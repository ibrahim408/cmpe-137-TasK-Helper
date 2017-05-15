//
//  ViewController.swift
//  event todo
//
//  Created by ibrahim ibrahim on 5/1/17.
//  Copyright © 2017 IBMibrahim. All rights reserved.
//

import UIKit
import EventKit
import CoreData


class EventViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var category: String?

    var eventsCoreDate : [Event] = []
    var selectedEvent: Event?
    // string of Category name
    // display Category with name "sports"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        getEventData()
        tableView.reloadData()
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        //resetAccessoryType()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let event = eventsCoreDate[indexPath.row]
        
        if event.completed == false{
            if event.isimportant{
                
                cell.textLabel?.text = "💢\(event.title!)"
            }else {
                cell.textLabel?.text = "\(event.title!)"
                
            }
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsCoreDate.count
    }
    
    
    func getEventData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
            //let request: NSFetchRequest<Event> = Event.fetchRequest()
            //request.predicate = NSPredicate(format: "completed == %@", NSNumber(value: false))
            //eventsCoreDate = try context.fetch(request)
            
            let request: NSFetchRequest<Event> = Event.fetchRequest()
            let p1 = NSPredicate(format: "completed == %@", NSNumber(value: false))
            let p2 = NSPredicate(format: "categoryID == %@", category!)
            let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [p1, p2])
            request.predicate  = predicate
            eventsCoreDate = try context.fetch(request)

            
            
        }catch{
            print("did not work")
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        
        if editingStyle == .delete{
            let event = eventsCoreDate[indexPath.row]
            
            if event.eventID != nil{
                delteEventFromKit(eventIdentifier: event.eventID!)
                
            }
            
            context.delete(event)
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do{
                eventsCoreDate = try context.fetch(Event.fetchRequest())
            }catch{
                print("did not work")
            }
        }
        
        tableView.reloadData()
        
    }
    
    
    
    func delteEventFromKit(eventIdentifier: String){
        let store = EKEventStore()
        store.requestAccess(to: .event) {(granted, error) in
            if !granted {
                print("did not work")
                return
            }
            
            let eventToRemove = store.event(withIdentifier: eventIdentifier)
            if (eventToRemove != nil) {
                do {
                    try store.remove(eventToRemove!, span: .thisEvent, commit: true)
                    
                } catch {
                    print("did not work")
                }
            }
            
            
        }
        
    }
    
    func resetAccessoryType() {
        for row in 0..<eventsCoreDate.count {
            if let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)){
                cell.accessoryType = .none
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //performSegue(withIdentifier: "eventDetailSegue", sender: eventsCoreDate[indexPath.row].title!)
        selectedEvent = eventsCoreDate[indexPath.row]
        performSegue(withIdentifier: "eventDetailSegue", sender: eventsCoreDate[indexPath.row])


     /*
        tableView.deselectRow(at: indexPath, animated: true)
         
        let event = eventsCoreDate[indexPath.row]
        
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.accessoryType == .none {
                cell.accessoryType = .checkmark
                
                event.completed = true;
                
            } else {
                cell.accessoryType = .none
                event.completed = false;
            }
        }
 */
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "eventDetailSegue"{
            let temp = segue.destination as! EventDetailViewController
            
  
            temp.event = selectedEvent!
        }
        
        
        if segue.identifier == "createEvent"{
            let temp = segue.destination as! AddEventViewController
            
            
            temp.catagory = category!
        }

    }

    
}


//
//  CompletedEventsViewController.swift
//  event todo
//
//  Created by ibrahim ibrahim on 5/10/17.
//  Copyright © 2017 IBMibrahim. All rights reserved.
//

import UIKit
import EventKit
import CoreData


class CompletedEventsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    
    @IBOutlet weak var tableView: UITableView!
    
    
    var eventsCoreDate : [Event] = []
    // display Category with events "sports"
    // display completed events
    
    
    func test(){
        /*
        var array : [String]
        array = ["one","two","one"]
        
        let itemToRemove = "one"
        
        while array.contains(itemToRemove) {
            if let itemToRemoveIndex = array.index(of: itemToRemove) {
                array.remove(at: itemToRemoveIndex)
            }
        }
        
        for events in eventsCoreDate{
            if  events.completed == true{
                eventsCoreDate[ind]
            }
        }
 */
        

        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        getEventData()
        
   
        /*
        competedEventsData = eventsCoreDate.filter({ (event) -> Bool in
            return event.completed
        })
 */
        
        tableView.reloadData()

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let event = eventsCoreDate[indexPath.row]
        
        

        
        if event.completed != false{
            if event.completed == true{
                if event.isimportant{
                    cell.textLabel?.text = "💢\(event.title!)"
                }else {
                    cell.textLabel?.text = "\(event.title!)"
                }
            }
            
            
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsCoreDate.count
    }
    
    
    func getEventData(){

        /*
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
         
            eventsCoreDate = try context.fetch(Event.fetchRequest())
        }catch{
            print("did not work")
        }
 */
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            //let request: NSFetchRequest<NSFetchRequestResult> = Event.fetchRequest()
            let request: NSFetchRequest<Event> = Event.fetchRequest()
            request.predicate = NSPredicate(format: "completed == %@", NSNumber(value: true))
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

}

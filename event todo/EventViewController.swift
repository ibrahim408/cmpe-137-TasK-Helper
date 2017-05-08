//
//  ViewController.swift
//  event todo
//
//  Created by ibrahim ibrahim on 5/1/17.
//  Copyright © 2017 IBMibrahim. All rights reserved.
//

import UIKit
import EventKit


class EventViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    var eventsCoreDate : [Event] = []
    
    
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
        
        let event = eventsCoreDate[indexPath.row]
        
        if event.isimportant{

            cell.textLabel?.text = "💢\(event.title!)"
        }else {
            cell.textLabel?.text = "\(event.title!)"

        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsCoreDate.count
    }

    
    func getEventData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
        eventsCoreDate = try context.fetch(Event.fetchRequest())
        }catch{
            print("did not work")
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        
        if editingStyle == .delete{
            let event = eventsCoreDate[indexPath.row]
            
            delteEventFromKit(eventIdentifier: event.eventID!)
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


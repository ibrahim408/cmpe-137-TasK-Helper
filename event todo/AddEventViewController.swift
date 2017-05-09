//
//  AddEventViewController.swift
//  event todo
//
//  Created by ibrahim ibrahim on 5/1/17.
//  Copyright © 2017 IBMibrahim. All rights reserved.
//

import UIKit
import EventKit

class AddEventViewController: UIViewController {

    
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var startDateField: UIDatePicker!
    @IBOutlet weak var endDateField: UIDatePicker!
    @IBOutlet weak var isImportant: UISwitch!

    
    override func viewDidLoad() {
        super.viewDidLoad()

 
    }
    
    @IBAction func createEvent(_ sender: Any) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let event = Event(context: context)
        
        // first check if text boxes are filled or not
        // if let check for all of them
        event.title = titleField.text!
        event.sDate = startDateField.date as NSDate
        event.eDate = endDateField.date as NSDate
        event.isimportant = isImportant.isOn
        
        

        let store = EKEventStore()
        store.requestAccess(to: .event) {(granted, error) in
            if !granted {
                print("did not work")
                return
            }
            
            let eventKit = EKEvent(eventStore: store)
            //event.isAllDay = true
            eventKit.title = self.titleField.text!
            eventKit.notes = "Discussion on stocks."

            
            eventKit.startDate = self.startDateField.date
            eventKit.endDate = self.endDateField.date
            eventKit.calendar = store.defaultCalendarForNewEvents
            do {
                try store.save(eventKit, span: .thisEvent, commit: true)
                event.eventID = eventKit.eventIdentifier
            } catch {
                print("did not work")
            }
            
            
        }
        

        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
        
    }
    

}

//
//  AddEventViewController.swift
//  event todo
//
//  Created by ibrahim ibrahim on 5/1/17.
//  Copyright © 2017 IBMibrahim. All rights reserved.
//

import UIKit
import EventKit

class AddEventViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    
    var catagory: String?
    
    var type = ["School","Orcale Arean","Work"]
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var startDateField: UIDatePicker!
    @IBOutlet weak var endDateField: UIDatePicker!
    @IBOutlet weak var isImportant: UISwitch!

    
    @IBOutlet var locationPicker: UIPickerView!
    @IBOutlet var testingLocation: UILabel!

    //var lat  = 37.7502778
    //var long = -122.2027778
    
    var lat  = 37.336079
    var long = -121.880454
    
    //var lat  = 37.336079
    //var long = 121.880454

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationPicker.dataSource = self
        locationPicker.delegate = self
        
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
        event.completed = false
        event.categoryID = catagory!
        
        

        let store = EKEventStore()
        store.requestAccess(to: .event) {(granted, error) in
            if !granted {
                print("did not work")
                return
            }
            
            let eventKit = EKEvent(eventStore: store)
            eventKit.title = self.titleField.text!

            
            /*
            let location = EKStructuredLocation(title: "oracle arena")
            location.geoLocation = CLLocation(
                latitude: 37.7502778, longitude: -122.2027778
            )
            */
            
            
            let location = EKStructuredLocation(title: self.testingLocation.text!)
            location.geoLocation = CLLocation(latitude: self.lat, longitude: self.long)
            eventKit.structuredLocation = location
            
            
            
            
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
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return type.count
    }
    

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        testingLocation.text = type[row]
        
        
        if(row == 0){
             lat  = 37.336079
             long = -121.880454
        }else if(row == 1){
             lat  = 37.7502778
             long = -122.2027778
        } else if (row == 2) {
             lat  = 37.210627
             long = -121.8075442
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return type[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    

}

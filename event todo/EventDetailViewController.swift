//
//  EventDetailViewController.swift
//  event todo
//
//  Created by ibrahim ibrahim on 5/13/17.
//  Copyright © 2017 IBMibrahim. All rights reserved.
//

import UIKit
import EventKit

extension NSDate {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd yyyy"
        return dateFormatter.string(from: self as Date)
    }
}


class EventDetailViewController: UIViewController {
  
    @IBOutlet weak var nameField: UILabel!
    @IBOutlet weak var testField: UILabel!
    @IBOutlet weak var testField2: UILabel!
    
    
    
    var event: Event?
    var starttDate = NSDate()
    var endDate = NSDate()
    var slectedlocatiol : CLLocation?




    
    override func viewDidLoad() {
        super.viewDidLoad()


        starttDate = (event?.sDate)!
        endDate = (event?.eDate)!
        

        nameField.text = event?.title
        //eventTitleField.text = "it me" //
       
        testField.text = starttDate.toString()
        testField2.text = endDate.toString()

    }


    @IBAction func compeltedEvent(_ sender: Any) {
        

        if event?.completed == false{
            event?.completed=true
        }
        
        navigationController!.popViewController(animated: true)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let eventStore = EKEventStore()
        
        
        if segue.identifier == "showMap"{
            let temp = segue.destination as! MapViewController
            
            let eventtemp = eventStore.event(withIdentifier: (event?.eventID)!)
            slectedlocatiol = eventtemp?.structuredLocation?.geoLocation
            
            temp.location = eventtemp?.structuredLocation?.geoLocation
        }
    }
    

    

    


}

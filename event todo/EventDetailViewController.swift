//
//  EventDetailViewController.swift
//  event todo
//
//  Created by ibrahim ibrahim on 5/13/17.
//  Copyright © 2017 IBMibrahim. All rights reserved.
//

import UIKit

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
    



    
    override func viewDidLoad() {
        super.viewDidLoad()


        starttDate = (event?.sDate)!
        endDate = (event?.eDate)!
        

        nameField.text = event?.title
        //eventTitleField.text = "it me"
       
        testField.text = starttDate.toString()
        testField2.text = endDate.toString()

    }


    @IBAction func compeltedEvent(_ sender: Any) {
        
        navigationController!.popViewController(animated: true)

        if event?.completed == false{
            event?.completed=true
        }
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

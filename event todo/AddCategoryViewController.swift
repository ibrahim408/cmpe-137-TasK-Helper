//
//  AddCategoryViewController.swift
//  event todo
//
//  Created by ibrahim ibrahim on 5/7/17.
//  Copyright © 2017 IBMibrahim. All rights reserved.
//

import UIKit

class AddCategoryViewController: UIViewController {

    
    
    @IBOutlet weak var titleField: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func createCategory(_ sender: Any) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let category = Category(context: context)
    
        
        // first check if text boxes are filled or not
        // if let check for all of them    
        category.title = titleField.text!
      
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
        
    }


}

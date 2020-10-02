//
//  NewCategoryViewController.swift
//  Documents Core Data Relationships
//
//  Created by obbrbt on 9/30/20.
//

import UIKit

class NewCategoryViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var titleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleTextField.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    
    @IBAction func saveCategory(_ sender: Any) {
        let category = Category(title: titleTextField.text ?? "")
        
        do {
            try category?.managedObjectContext?.save()
            
            self.navigationController?.popViewController(animated: true)
        } catch {
            print("Could not save category. \(error).")
        }
    }
}


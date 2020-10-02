//
//  NewDocumentViewController.swift
//  Documents Core Data Relationships
//
//  Created by obbrbt on 9/30/20.
//

import UIKit

class NewDocumentViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var nameTextField: UITextField!
    
    var document: Document?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.delegate = self
        contentTextView.delegate = self
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameTextField.resignFirstResponder()
        contentTextView.resignFirstResponder()
    }
    
    @IBAction func saveDocument(_ sender: Any) {
        guard let name = nameTextField.text else {
            return
        }
        
        let content = contentTextView.text
        
        if document == nil {
            document = Document(name: name, content: content)
        } else {
            document?.update(name: name, content: content)
        }
            
        if let document = document {
            do {
                let managedContext = document.managedObjectContext
                try managedContext?.save()
            } catch {
                print("Document could not be saved. \(error).")
            }
        } else {
            print("Document could not be created.")
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func nameChanged(_ sender: Any) {
        title = nameTextField.text
    }
}

extension NewDocumentViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

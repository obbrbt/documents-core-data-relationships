//
//  DocumentsViewController.swift
//  Documents Core Data Relationships
//
//  Created by obbrbt on 9/30/20.
//

import UIKit
import CoreData

class DocumentsViewController: UIViewController {
    
    @IBOutlet weak var documentsTableView: UITableView!
    
    let dateFormatter = DateFormatter()
    
    var document: Document?
    var category: Category?
    var documents = [Document]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Documents"

        dateFormatter.timeStyle = .long
        dateFormatter.dateStyle = .long
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchDocuments()
        documentsTableView.reloadData()
    }
    
    func fetchDocuments() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Document> = Document.fetchRequest()
        
        do {
            documents = try managedContext.fetch(fetchRequest)
        } catch {
            print("Fetch could not be performed.")
            
            return
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addDocument(_ sender: Any) {
        performSegue(withIdentifier: "addNewDocument", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? NewDocumentViewController else {
            return
        }
        
        destination.document = document
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func deleteDocument(at indexPath: IndexPath) {
        guard let document = category?.documents?[indexPath.row], let managedContext = document.managedObjectContext else {
            return
        }
        
        managedContext.delete(document)
        
        do {
            try managedContext.save()
            
            documentsTableView.deleteRows(at: [indexPath], with: .automatic)
        } catch {
            showAlert(message: "Could not delete document.")
            
            documentsTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}

extension DocumentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = documentsTableView.dequeueReusableCell(withIdentifier: "documentCell", for: indexPath)
        
        if let cell = cell as? DocumentsTableViewCell {
            let document = documents[indexPath.row]
            cell.nameLabel.text = document.name
            cell.sizeLabel.text = String(document.size) + " bytes"
            
            if let rawModifiedDate = document.rawModifiedDate {
                cell.dateLabel.text = dateFormatter.string(from: rawModifiedDate)
            } else {
                cell.dateLabel.text = "unknown date"
            }
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteDocument(at: indexPath)
        }
    }
}

extension DocumentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "addNewDocument", sender: self)
    }
}

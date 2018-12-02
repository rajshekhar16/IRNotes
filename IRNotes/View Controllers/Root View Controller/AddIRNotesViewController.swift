//
//  AddIRNotesViewController.swift
//  IRNotes
//
//  Created by Raj Shekhar on 02/12/2018.
//  Copyright © 2018 Raj Shekhar. All rights reserved.
//

import UIKit
import CoreData

class AddIRNotesViewController: UIViewController {

    var managedContextObject:NSManagedObjectContext?
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Add Note"
    
        // Do any additional setup after loading the view.
    }
    
    @IBAction func SaveNotes(_ sender: UIBarButtonItem) {
        
        guard let managedObjectContext = managedContextObject else { return }
        guard let title = titleTextField.text, !title.isEmpty else {
            self.showAlert(with: "Title Missing", and: "Your note doesn't have a title.")
            return }
        
        //Create Note
        let note = IRNote(context: managedObjectContext)
        note.title = title
        note.createdAt = Date()
        note.updatedAt = Date()
        note.contents = contentsTextView.text
        
        // Pop View Controller
        _ = navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

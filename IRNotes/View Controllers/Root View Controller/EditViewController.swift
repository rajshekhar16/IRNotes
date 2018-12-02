//
//  EditViewController.swift
//  IRNotes
//
//  Created by Raj Shekhar on 02/12/2018.
//  Copyright © 2018 Raj Shekhar. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {

    @IBOutlet var editTitleTextField: UITextField!
    @IBOutlet var editContentsTextView: UITextView!
    
    var note:IRNote?
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        title = "Edit Note"
        
        setUpView()
    }
    
    
    private func setUpView()
    {
        editTitleTextField.text = note?.title
        editContentsTextView.text = note?.contents
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        guard let note = note else { return }
        
        
        if let title = editTitleTextField.text,!title.isEmpty,note.title != title {
            note.title = title
        }
        
        // Update Contents
        if note.contents != editContentsTextView.text {
            note.contents = editContentsTextView.text
        }
        
        // Update Updated At
        if note.isUpdated {
            note.updatedAt = Date()
        }
        
    }
}

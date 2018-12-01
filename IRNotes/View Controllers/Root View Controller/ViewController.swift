//
//  ViewController.swift
//  IRNotes
//
//  Created by Raj Shekhar on 01/12/2018.
//  Copyright © 2018 Raj Shekhar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private enum Segue {
        
        static let AddNote = "AddNote"
    }
    
    private var irCoreDataMgr = IRCoreDataManager(modelName: "IRNotes")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let identifier = segue.identifier else { return }
        
        switch identifier{
        case Segue.AddNote:
            guard let destination = segue.destination as? AddIRNotesViewController else{
                return
            }
            
            destination.managedContextObject = irCoreDataMgr.managedObjectContext
            
        default:
            break
        }
    }


}


//
//  ViewController.swift
//  IRNotes
//
//  Created by Raj Shekhar on 01/12/2018.
//  Copyright © 2018 Raj Shekhar. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    private enum Segue {
        
        static let AddNote = "AddNote"
    }
    
    var notes : [IRNote]?
    {
        didSet{
           updateView()
        }
    }
    
    private var hasNotes: Bool {
        guard let notes = notes else { return false }
        return notes.count > 0
    }

    private let estimatedRowHeight = CGFloat(44.0)

    //Iboutlets
    @IBOutlet weak var notesView: UIView!
    @IBOutlet weak var msgLabel: UILabel!
    @IBOutlet weak var noteTableView: UITableView!
   
    
    private var irCoreDataMgr = IRCoreDataManager(modelName: "IRNotes")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "Notes"
        
        setupView()
        
        fetchRequest()
    }
    
    private lazy var updatedAtDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, HH:mm"
        return dateFormatter
    }()
    
     // MARK: - View Methods
    
    private func updateView()
    {
        noteTableView.isHidden = !hasNotes
        msgLabel.isHidden = hasNotes
    }
    
    private func setupView() {
        setupMessageLabel()
        setupTableView()
    }
    
    private func setupMessageLabel() {
        msgLabel.text = "You don't have any notes yet."
    }

    
    private func setupTableView() {
        noteTableView.isHidden = true
        noteTableView.estimatedRowHeight = estimatedRowHeight
        noteTableView.rowHeight = UITableView.automaticDimension
    }
    
    private func fetchRequest() {
        
        //Create fetch request
        let fetchRequest: NSFetchRequest<IRNote> = IRNote.fetchRequest()
        
        //Configure Fetch Request
        fetchRequest.sortDescriptors = [ NSSortDescriptor(key: #keyPath(IRNote.updatedAt), ascending: false) ]
        
        //Perform fetch request
        irCoreDataMgr.managedObjectContext.performAndWait {
            do{
                //Execute Fetch Request
                let notes = try fetchRequest.execute()
                
                self.notes = notes
                
                noteTableView.reloadData()
            }
            catch{
                print("Unable to Execute Fetch Request")
                print("\(error), \(error.localizedDescription)")
            }
            
        }
        
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


extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return hasNotes ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let notes = notes else { return 0 }
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Fetch Note
        guard let note = notes?[indexPath.row] else {
            fatalError("Unexpected Index Path")
        }
        
        // Dequeue Reusable Cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NotesTableViewCell.reuseIdentifier, for: indexPath) as? NotesTableViewCell else {
            fatalError("Unexpected Index Path")
        }
        
        // Configure Cell
           cell.titleLabel.text = note.title
           cell.contentsLabel.text = note.contents
           cell.dateLabel.text = updatedAtDateFormatter.string(from: note.updatedAtAsDate)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    // UITableViewAutomaticDimension calculates height of label contents/text
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Swift 4.2 onwards
        return UITableView.automaticDimension
        
   }
    
}

//
//  NotesTableViewCell.swift
//  IRNotes
//
//  Created by Raj Shekhar on 02/12/2018.
//  Copyright © 2018 Raj Shekhar. All rights reserved.
//

import UIKit

class NotesTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static let reuseIdentifier = "NotesTableViewCell"

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentsLabel: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

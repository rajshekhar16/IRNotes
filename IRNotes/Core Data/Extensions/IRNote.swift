//
//  IRNote.swift
//  IRNotes
//
//  Created by Raj Shekhar on 02/12/2018.
//  Copyright © 2018 Raj Shekhar. All rights reserved.
//

import UIKit

extension IRNote
{
   
        var updatedAtAsDate: Date {
            return updatedAt ?? Date()
        }
        
        var createdAtAsDate: Date {
            return createdAt ?? Date()
        }
        
    
}

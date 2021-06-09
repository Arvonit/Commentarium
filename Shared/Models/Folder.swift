//
//  Folder.swift
//  Commentarium
//
//  Created by Arvind on 6/8/21.
//

import Foundation
import CoreData

extension Folder {
    
    convenience init(name: String, icon: String = "folder", context: NSManagedObjectContext) {
        self.init(context: context)
        self.name = name
        self.icon = icon
    }
    
    var safeName: String {
        get { name ?? "Unnamed Folder" }
        set { name = newValue }
    }
    
    var safeIcon: String {
        get { icon ?? "tag" }
        set { icon = newValue }
    }
    
    var safeNotes: Set<Note> {
        get { notes as? Set<Note> ?? [] }
        set { notes = newValue as NSSet }
    }
    
}

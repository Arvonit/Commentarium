//
//  Note.swift
//  Commentarium
//
//  Created by Arvind on 6/7/21.
//

import Foundation
import CoreData

extension Note {
    
    convenience init(
        content: String,
        date: Date = Date(),
        id: UUID = UUID(),
        isInTrash: Bool = false,
        folder: Folder? = nil,
        context: NSManagedObjectContext
    ) {
        self.init(context: context)
        self.content = content
        self.dateCreated = date
        self.dateUpdated = date
        self.id = id
        self.folder = folder
        self.isInTrash = isInTrash
    }
    
    var safeContent: String {
        get { content ?? "" }
        set { content = newValue }
    }
    
    var safeDateCreated: Date {
        get { dateCreated ?? dateUpdated ?? Date() }
        set { dateCreated = newValue }
    }
    
    var safeDateUpdated: Date {
        get { dateUpdated ?? dateCreated ?? Date() }
        set { dateUpdated = newValue }
    }
    
    var safeID: UUID {
        get { id ?? UUID() }
        set { id = newValue }
    }
    
}

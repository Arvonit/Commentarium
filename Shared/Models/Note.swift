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
        isPinned: Bool = false,
        isInTrash: Bool = false,
        folder: Folder? = nil,
        context: NSManagedObjectContext
    ) {
        self.init(context: context)
        self.content = content
        self.dateCreated = date
        self.dateUpdated = date
        self.id = id
        self.isPinned = isPinned
        self.isInTrash = isInTrash
        self.folder = folder
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
    
    var title: String {
        return safeContent != ""
                ? String(safeContent.split(whereSeparator: \.isNewline)[0])
                : "New note"
    }
    
    var contentWithoutTitle: String {
        let splitContent = safeContent.split(whereSeparator: \.isNewline)
        return safeContent != ""
                ? splitContent[1..<splitContent.count].joined(separator: "\n")
                : "Add some text"
    }
    
}

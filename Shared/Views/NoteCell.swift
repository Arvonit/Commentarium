//
//  NoteCell.swift
//  Commentarium
//
//  Created by Arvind on 6/8/21.
//

import Foundation
import SwiftUI

struct NoteCell: View {
    let note: Note
    let folder: Folder?
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy h:mm a"
        return formatter
    }()
    
    init(note: Note, folder: Folder? = nil) {
        self.note = note
        self.folder = folder
    }
    
    var body: some View {
        NavigationLink(destination: NoteEditor(note: note, folder: folder)) {
            VStack(alignment: .leading) {
                Text(note.safeDateUpdated, formatter: dateFormatter)
                    .font(.subheadline)
                Text(title(for: note))
                    .font(.headline)
                    .lineLimit(2)
                Text(contentWithoutTitle(for: note))
                    .font(.callout)
                    .lineLimit(3)
            }
        }
    }
    
    func title(for note: Note) -> String {
        return String(note.safeContent.split(whereSeparator: \.isNewline)[0])
    }
    
    func contentWithoutTitle(for note: Note) -> String {
        let splitContent = note.safeContent.split(whereSeparator: \.isNewline)
        return splitContent[1..<splitContent.count].joined(separator: "\n")
    }
}

struct NoteCellPreviews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

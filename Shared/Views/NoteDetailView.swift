//
//  NoteDetailView.swift
//  Commentarium
//
//  Created by Arvind on 6/10/21.
//

import SwiftUI

struct NoteDetailView: View {
    let note: Note
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy h:mm a"
        return formatter
    }()
    
    var body: some View {
        List {
            Section("Details") {
                Text("Date Created")
                    .badge(dateFormatter.string(from: note.safeDateCreated))
                Text("Date Updated")
                    .badge(dateFormatter.string(from: note.safeDateUpdated))
            }
            
            Section("Folder") {
                if let folder = note.folder {
                    Label(folder.safeName, systemImage: folder.safeIcon)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct NoteDetailViewPreviews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

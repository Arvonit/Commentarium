//
//  NoteCellView.swift
//  Commentarium
//
//  Created by Arvind on 6/8/21.
//

import Foundation
import SwiftUI

struct NoteCellView: View {
    let note: Note
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy h:mm a"
        return formatter
    }()
    
    var body: some View {
        NavigationLink(destination: NoteEditorView(note: note, folder: note.folder)) {
            VStack(alignment: .leading) {
                Text(note.safeDateUpdated, formatter: dateFormatter)
                    .font(.subheadline)
                Text(note.title)
                    .font(.headline)
                    .lineLimit(2)
                Text(note.contentWithoutTitle)
                    .font(.callout)
                    .lineLimit(3)
            }
        }
    }    
}

struct NoteCellPreviews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

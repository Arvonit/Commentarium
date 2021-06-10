//
//  NoteEditor.swift
//  Commentarium
//
//  Created by Arvind on 6/9/21.
//

import SwiftUI

struct NoteEditor: View {
    @EnvironmentObject private var dataController: DataController
    @State private var content: String
    @State var note: Note?
    let folder: Folder?
    
    init(note: Note? = nil, folder: Folder? = nil) {
        self.note = note
        self.content = note?.safeContent ?? ""
        self.folder = folder
    }
    
    var body: some View {
        TextEditor(text: $content)
            .padding(.horizontal)
            .navigationBarTitleDisplayMode(.inline)
            .onChange(of: content) { newValue in
                if let safeNote = note {
                    safeNote.safeDateUpdated = .now
                    safeNote.content = content
                } else {
                    note = Note(content: content, folder: folder, context: dataController.context)
                    print("created a new note with folder \(folder?.name ?? "none")")
                }
                dataController.save()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Label("Info", systemImage: "info.circle")
                    }
                }
            }
    }
}

struct NoteEditor_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

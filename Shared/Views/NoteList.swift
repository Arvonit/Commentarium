//
//  NoteList.swift
//  Commentarium
//
//  Created by Arvind on 6/8/21.
//

import SwiftUI

struct NoteList: View {
    @EnvironmentObject private var dataController: DataController
    @FetchRequest private var notes: FetchedResults<Note>
    let folder: Folder
    
    init(folder: Folder) {
        self.folder = folder
        self._notes = FetchRequest<Note>(
            sortDescriptors: [SortDescriptor<Note>(\.dateUpdated, order: .reverse)],
            predicate: NSPredicate(format: "folder == %@ AND isInTrash == NO", folder),
            animation: .default
        )
    }
    
    var body: some View {
        List {
            ForEach(notes) { note in
                NoteCell(note: note, folder: folder)
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            note.isInTrash = true
                            dataController.save()
                        } label: {
                            Image(systemName: "trash.fill")
                        }
                        .tint(.red)
                    }
            }
            .onDelete { indices in
                for index in indices {
                    notes[index].isInTrash = true
                }
                dataController.save()
            }
        }
        .navigationTitle(folder.safeName)
        .listStyle(.insetGrouped)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: NoteEditor(folder: folder)) {
                    Button {
                        
                    } label: {
                        Label("Add", systemImage: "plus")
                    }
                }
            }
        }
    }
}

struct NoteListPreviews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

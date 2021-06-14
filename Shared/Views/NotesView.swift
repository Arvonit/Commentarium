//
//  NotesView.swift
//  Commentarium
//
//  Created by Arvind on 6/8/21.
//

import SwiftUI

struct NotesView: View {
    @EnvironmentObject private var dataController: DataController
    @FetchRequest private var notes: FetchedResults<Note>
    private let folder: Folder?
    private let navigationTitle: String

    init(folder: Folder? = nil) {
        self.folder = folder
        self.navigationTitle = folder?.safeName ?? "All Notes"
        
        let predicate: NSPredicate
        if let folder = folder {
            predicate = NSPredicate(format: "folder == %@ AND isInTrash == NO", folder)
        } else {
            predicate = NSPredicate(format: "isInTrash == NO")
        }
        
        self._notes = FetchRequest(
            sortDescriptors: [SortDescriptor<Note>(\.dateUpdated, order: .reverse)],
            predicate: predicate,
            animation: .default
        )
    }

    var body: some View {
        List {
            ForEach(notes) { note in
                NoteCellView(note: note)
                    .swipeActions(edge: .trailing) {
                        deleteSwipeAction(note: note)
                    }
                    .contextMenu {
                        NavigationLink(destination: Text("foo")) {
                            Label("Edit", systemImage: "pencil")
                        }
                        deleteMenuItem(note: note)
                    }
            }
            .onDelete { delete(at: $0) }
        }
        .navigationTitle(navigationTitle)
        .listStyle(.insetGrouped)
        .toolbar { addNoteToolbarItem }
    }
    
    private func delete(note: Note) {
        note.isInTrash = true
        dataController.save()
    }

    private func deleteSwipeAction(note: Note) -> some View {
        Button(role: .destructive) {
            delete(note: note)
        } label: {
            Image(systemName: "trash.fill")
        }
        .tint(.red)
    }
    
    private func deleteMenuItem(note: Note) -> some View {
        Button(role: .destructive) {
            delete(note: note)
        } label: {
            Label("Move to trash", systemImage: "trash")
        }
    }
    
    private func delete(at indices: IndexSet) {
        for index in indices {
            notes[index].isInTrash = true
        }
        dataController.save()
    }

    private var addNoteToolbarItem: some ToolbarContent {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
            NavigationLink(destination: NoteEditorView(folder: folder)) {
                Button {

                } label: {
                    Label("Add Note", systemImage: "square.and.pencil")
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

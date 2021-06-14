//
//  DeletedNotesView.swift
//  Commentarium
//
//  Created by Arvind on 6/9/21.
//

import SwiftUI

struct DeletedNotesView: View {
    @EnvironmentObject private var dataController: DataController
    @FetchRequest private var notes: FetchedResults<Note>

    init() {
        self._notes = FetchRequest(
            sortDescriptors: [SortDescriptor<Note>(\.dateUpdated, order: .reverse)],
            predicate: NSPredicate(format: "isInTrash == YES"),
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
                    .swipeActions(edge: .leading) {
                        restoreSwipeAction(note: note)
                    }
                    .contextMenu {
                        deleteMenuItem(note: note)
                    }
            }
            .onDelete { delete(at: $0) }
        }
        .navigationTitle("Trash")
        .listStyle(.insetGrouped)
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
            Label("Delete", systemImage: "trash")
        }
    }
    
    private func restoreSwipeAction(note: Note) -> some View {
        Button(role: .destructive) {
            note.isInTrash = false
            dataController.save()
        } label: {
            Image(systemName: "tray.fill")
        }
        .tint(.blue)
    }
    
    private func delete(note: Note) {
        dataController.delete(note)
        dataController.save()
    }
    
    private func delete(at indices: IndexSet) {
        for index in indices {
            dataController.delete(notes[index])
        }
        dataController.save()
    }
}

struct DeletedNotes_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

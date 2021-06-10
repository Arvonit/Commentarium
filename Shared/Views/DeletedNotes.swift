//
//  DeletedNotes.swift
//  Commentarium
//
//  Created by Arvind on 6/9/21.
//

import SwiftUI

struct DeletedNotes: View {
    @EnvironmentObject private var dataController: DataController
    @FetchRequest private var notes: FetchedResults<Note>
    
    init() {
        self._notes = FetchRequest<Note>(
            sortDescriptors: [SortDescriptor<Note>(\.dateUpdated, order: .reverse)],
            predicate: NSPredicate(format: "isInTrash == YES"),
            animation: .default
        )
    }
    
    var body: some View {
        List {
            ForEach(notes) { note in
                NoteCell(note: note)
                    .swipeActions(edge: .leading) {
                        Button {
                            note.isInTrash = false
                        } label: {
                            Image(systemName: "tray.fill")
                        }
                        .tint(.blue)
                    }
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            dataController.delete(note)
                            dataController.save()
                        } label: {
                            Image(systemName: "trash.fill")
                        }
                        .tint(.red)
                    }
            }
            .onDelete { indices in
                for index in indices {
                    dataController.delete(notes[index])
                }
                dataController.save()
            }
        }
        .navigationTitle("Trash")
        .listStyle(.insetGrouped)
    }
}

struct DeletedNotes_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  AllNotes.swift
//  Commentarium
//
//  Created by Arvind on 6/9/21.
//

import SwiftUI

struct AllNotes: View {
    @EnvironmentObject private var dataController: DataController
    @FetchRequest private var notes: FetchedResults<Note>
    
    init() {
        self._notes = FetchRequest<Note>(
            sortDescriptors: [SortDescriptor<Note>(\.dateUpdated, order: .reverse)],
            predicate: NSPredicate(format: "isInTrash == NO"),
            animation: .default
        )
    }
    
    var body: some View {
        List {
            ForEach(notes) { note in
                NoteCell(note: note)
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
        .navigationTitle("All Notes")
        .listStyle(.insetGrouped)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: NoteEditor()) {
                    Button {
                        
                    } label: {
                        Label("Add", systemImage: "plus")
                    }
                }
            }
        }
    }
}

struct AllNotes_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

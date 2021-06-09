//
//  FolderList.swift
//  Commentarium
//
//  Created by Arvind on 6/8/21.
//

import SwiftUI

struct FolderList: View {
    @EnvironmentObject private var dataController: DataController
    @FetchRequest(sortDescriptors: [SortDescriptor<Folder>(\.name)], animation: .default)
    private var folders: FetchedResults<Folder>
    @State private var selectedFolders = Set<Folder>()
    @State private var showSheet = false
    @State private var showDeleteAlert = false
    
    var body: some View {
        List(selection: $selectedFolders) {
            ForEach(folders) { folder in
                NavigationLink(destination: NoteList()) {
                    Label(folder.safeName, systemImage: folder.safeIcon)
                }
            }
            .onDelete { indices in
                for index in indices {
                    dataController.delete(folders[index])
                }
                dataController.save()
            }
        }
        .navigationTitle("Folders")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showSheet.toggle()
                } label: {
                    Label("New", systemImage: "plus")
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    showDeleteAlert.toggle()
                } label: {
                    Label("Trash", systemImage: "trash")
                }
            }
        }
        .sheet(isPresented: $showSheet) {
            AddFolder()
        }
        .confirmationDialog(
            "All notes and folders will be deleted.",
            isPresented: $showDeleteAlert,
            titleVisibility: .visible
        ) {
            Button("Delete everything", role: .destructive) {
                dataController.deleteAll()
            }
            Button("Cancel", role: .cancel) {}
        }
    }
}

struct FolderListPreviews: PreviewProvider {
    static var previews: some View {
        FolderList()
    }
}

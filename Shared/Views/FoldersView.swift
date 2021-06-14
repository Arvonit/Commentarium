//
//  FoldersView.swift
//  Commentarium
//
//  Created by Arvind on 6/8/21.
//

import SwiftUI

struct FoldersView: View {
    @EnvironmentObject private var dataController: DataController
    @FetchRequest private var folders: FetchedResults<Folder>
    @State private var selectedFolders = Set<Folder>()
    @State private var showAddSheet = false
    @State private var showEditSheet = false
    @State private var showDeleteAlert = false
    @StateObject private var selectedFolder: Folder? = nil
    
    init() {
        self._folders = FetchRequest<Folder>(sortDescriptors: [.init(\.name)], animation: .default)
    }
    
    var body: some View {
        List(selection: $selectedFolders) {
            NavigationLink(destination: NotesView()) {
                Label("All", systemImage: "tray.full")
            }
            
            NavigationLink(destination: DeletedNotesView()) {
                Label("Trash", systemImage: "trash")
            }
            
            Section(header: Text("Folders")) {
                ForEach(folders) { folder in
                    NavigationLink(destination: NotesView(folder: folder)) {
                        Label(folder.safeName, systemImage: folder.safeIcon)
                    }
                    .swipeActions(edge: .trailing) {
                        deleteSwipeAction(folder: folder)
                    }
                    .contextMenu {
                        editMenuItem(folder: folder)
                        deleteMenuItem(folder: folder)
                    }
                }
                .onDelete { delete(at: $0) }
            }
        }
        .navigationTitle("Commentarium")
        .listStyle(.sidebar)
        .toolbar {
            deleteAllNotesToolbarItem
            addFolderToolbarItem
        }
        .sheet(isPresented: $showAddSheet) {
            AddEditFolderView()
        }
        .sheet(isPresented: $showEditSheet) {
            EditFolderView(folder: $selectedFolder)
        }
        .confirmationDialog(
            "All notes will be deleted.",
            isPresented: $showDeleteAlert,
            titleVisibility: .visible
        ) {
            Button("Delete all notes", role: .destructive) {
                dataController.deleteAllNotes()
            }
            Button("Cancel", role: .cancel) {}
        }
    }
    
    private func deleteSwipeAction(folder: Folder) -> some View {
        Button(role: .destructive) {
            delete(folder: folder)
        } label: {
            Image(systemName: "trash.fill")
        }
        .tint(.red)
    }
    
    private func deleteMenuItem(folder: Folder) -> some View {
        Button(role: .destructive) {
            delete(folder: folder)
        } label: {
            Label("Delete", systemImage: "trash")
        }
    }
    
    private func editMenuItem(folder: Folder) -> some View {
        Button {
            selectedFolder = folder
            showEditSheet.toggle()
        } label: {
            Label("Edit", systemImage: "pencil")
        }
    }
    
    private var deleteAllNotesToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .bottomBar) {
            Button(role: .destructive) {
                showDeleteAlert.toggle()
            } label: {
                Label("Delete All Notes", systemImage: "trash")
            }
        }
    }
    
    private var addFolderToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                showAddSheet.toggle()
            } label: {
                Label("Add Folder", systemImage: "folder.badge.plus")
            }
        }
    }
    
    private func delete(at indices: IndexSet) {
        for index in indices {
            dataController.delete(folders[index])
        }
        dataController.save()
    }
    
    private func delete(folder: Folder) {
        dataController.delete(folder)
        dataController.save()
    }
}

struct FolderListPreviews: PreviewProvider {
    static var previews: some View {
        FoldersView()
    }
}

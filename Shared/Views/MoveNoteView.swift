//
//  MoveNoteView.swift
//  Commentarium
//
//  Created by Arvind on 6/15/21.
//

import SwiftUI

// TODO: Fix
struct MoveNoteView: View {
    @FetchRequest<Folder>(
        sortDescriptors: [SortDescriptor<Folder>(\.name)],
        animation: .default
    )
    private var folders
    @Environment(\.presentationMode) private var presentationMode
    @State private var selectedFolder: Folder?
    
    var body: some View {
        NavigationView {
            List(selection: $selectedFolder) {
                ForEach(folders) { folder in
                    Label(folder.safeName, systemImage: folder.safeIcon)
                        .onTapGesture {
                            selectedFolder = folder
                        }
                }
            }
            .navigationTitle("Select a Folder")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", role: .cancel) {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

struct ChangeFolderView_Previews: PreviewProvider {
    static var previews: some View {
        MoveNoteView()
    }
}

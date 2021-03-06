//
//  EditFolderView.swift
//  Commentarium
//
//  Created by Arvind on 6/13/21.
//

import SwiftUI

// TODO: Fix
struct EditFolderView: View {
    @EnvironmentObject private var dataController: DataController
    @Environment(\.presentationMode) private var presentationMode
    @State private var name: String
    @State private var icon: String
    @Binding private var folder: Folder?
    private let allIcons = [
        "folder",
        "safari",
        "book.closed",
        "lightbulb",
        "laptopcomputer",
        "chevron.left.forwardslash.chevron.right",
        "pencil"
    ]
    
    init(folder: Binding<Folder?>) {
        self._folder = folder
        self._name = State(initialValue: folder.wrappedValue?.safeName ?? "")
        self._icon = State(initialValue: folder.wrappedValue?.safeIcon ?? "folder")
    }
        
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Icon", selection: $icon) {
                    ForEach(allIcons, id: \.self) {
                        Image(systemName: $0)
                            .foregroundColor(.blue)
                    }
                }
            }
            .navigationTitle(self.name == "" ? "Add Folder" : "Edit \(self.name)")
            .toolbar {
                doneToolbarItem
                cancelToolbarItem
            }
        }
        .interactiveDismissDisabled()
    }
    
    private var doneToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button("Done") {
//                if folder == nil && name != "" && icon != "" {
//                    let _ = Folder(name: name, icon: icon, context: dataController.context)
//                } else if let safeFolder = folder {
//                    safeFolder.safeName = name
//                    safeFolder.safeIcon = icon
//                }
            
                if let folder = folder {
                    if name != folder.safeName || icon != folder.safeIcon {
                        folder.name = name
                        folder.icon = icon
                    }
                }
                
                dataController.save()
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    private var cancelToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct EditFolderView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

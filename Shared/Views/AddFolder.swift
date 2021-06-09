//
//  AddFolder.swift
//  Commentarium
//
//  Created by Arvind on 6/8/21.
//

import SwiftUI

struct AddFolder: View {
    @EnvironmentObject private var dataController: DataController
    @Environment(\.presentationMode) var presentationMode
    @State private var name = ""
    @State private var icon = "folder"
    private let icons = ["folder", "safari", "book.closed", "lightbulb", "laptopcomputer",
                         "chevron.left.forwardslash.chevron.right", "pencil"]
        
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Icon", selection: $icon) {
                    ForEach(icons, id: \.self) {
                        Image(systemName: $0)
                    }
                }
            }
            .navigationTitle("Add folder")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        if name != "" && icon != "" {
                            let _ = Folder(name: name, icon: icon, context: dataController.context)
                            dataController.save()
                        }
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
        .interactiveDismissDisabled()
    }
}

struct AddFolder_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

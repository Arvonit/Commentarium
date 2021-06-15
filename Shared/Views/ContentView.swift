//
//  ContentView.swift
//  Commentarium
//
//  Created by Arvind on 6/7/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var dataController = DataController()
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        NavigationView {
            // When in landscape mode, use a triple column split view, otherwise use a stack view
            if horizontalSizeClass == .regular {
                FoldersView()
                Text("Select a folder...")
                Text("Select a note...")
            } else {
                FoldersView()
            }
        }
        .environment(\.managedObjectContext, dataController.context)
        .environmentObject(dataController)
    }
}

struct ContentViewPreviews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

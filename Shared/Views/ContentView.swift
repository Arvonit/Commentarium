//
//  ContentView.swift
//  Commentarium
//
//  Created by Arvind on 6/7/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var dataController = DataController()
    
    var body: some View {
        NavigationView {
            FoldersView()
//            Text("Select a folder...")
//            Text("Select a note...")
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

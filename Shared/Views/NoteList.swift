//
//  NoteList.swift
//  Commentarium
//
//  Created by Arvind on 6/8/21.
//

import SwiftUI

struct NoteList: View {
    var body: some View {
        List {
            VStack(alignment: .leading) {
                Text("Hello, world!")
                    .font(.headline)
                Text("This is a test")
                    .font(.subheadline)
            }
        }
        .navigationTitle("Notes")
    }
}

struct NoteListPreviews: PreviewProvider {
    static var previews: some View {
        NoteList()
    }
}

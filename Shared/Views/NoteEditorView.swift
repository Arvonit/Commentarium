//
//  NoteEditorView.swift
//  Commentarium
//
//  Created by Arvind on 6/9/21.
//

import SwiftUI
import UIKit

struct NoteEditorView: View {
    @EnvironmentObject private var dataController: DataController
    @State private var content: String
    @State var note: Note?
    let folder: Folder?
    
    init(note: Note? = nil, folder: Folder? = nil) {
        self.note = note
        self.content = note?.safeContent ?? ""
        self.folder = folder
    }
    
    var body: some View {
        Editor(text: $content)
            .padding(.horizontal)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("")
            .onChange(of: content) { newValue in
                if let safeNote = note {
                    safeNote.safeDateUpdated = .now
                    safeNote.content = content
                } else {
                    note = Note(content: content, folder: folder, context: dataController.context)
                    print("created a new note with folder \(folder?.name ?? "none")")
                }
                dataController.save()
            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    if let safeNote = note {
//                        NavigationLink(destination: NoteDetailView(note: safeNote)) {
//                            Button(action: {}) {
//                                Label("Info", systemImage: "info.circle")
//                            }
//                        }
//                    }
//                }
//            }
    }
}

struct Editor: UIViewRepresentable {
    @Binding var text: String
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        
        textView.delegate = context.coordinator
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.autocapitalizationType = .sentences
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        // The selectedRange bit is needed to prevent the cursor to jumping to the bottom of the
        // page (a rather bizzare bug/feature?)
        let selectedRange = uiView.selectedRange
        uiView.text = text
        uiView.selectedRange = selectedRange
        uiView.scrollRangeToVisible(selectedRange)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator($text)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var text: Binding<String>

        init(_ text: Binding<String>) {
            self.text = text
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.text.wrappedValue = textView.text
        }
    }
}

struct NoteEditor_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

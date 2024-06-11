//
//  EditFolderNameView.swift
//  myanki
//
//  Created by 劉明正 on 2024/06/11.
//

import SwiftUI

struct EditFolderNameView: View {
    @Binding var folderName: String
    @Binding var isPresented: Bool
    var onCommit: () -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Edit Folder Name")) {
                    TextField("Folder Name", text: $folderName, onCommit: onCommit)
                }
            }
            .navigationBarTitle("Edit Folder Name")
            .navigationBarItems(trailing: Button("Done") {
                isPresented = false
                onCommit()
            })
        }
//        .onAppear {
//            folderName = folderName.trimmingCharacters(in: .whitespacesAndNewlines)
//        }
    }
}


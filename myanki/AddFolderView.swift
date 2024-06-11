//
//  AddFolderView.swift
//  myanki
//
//  Created by 劉明正 on 2024/06/11.
//

import SwiftUI

struct AddFolderView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var folderName = ""
    @ObservedObject var viewModel: FolderViewModel
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Folder Name")) {
                    TextField("Enter folder name", text: $folderName)
                }
            }
            .navigationTitle("Add New Folder")
            .navigationBarItems(trailing: Button("Done") {
                viewModel.addFolder(name: folderName)
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

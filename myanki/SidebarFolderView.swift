//
//  SidebarFolderView.swift
//  myanki
//
//  Created by 劉明正 on 2024/06/11.
//

import SwiftUI

struct SidebarFolderView: View {
    @ObservedObject var viewModel: FolderViewModel
    @Binding var showingAddFolderView: Bool
    
    var body: some View {
        List {
            ForEach(viewModel.folders) { folder in
                NavigationLink(destination: FolderDetailView(viewModel: viewModel, folder: folder)) {
                    Text(folder.name)
                }
            }
            .onDelete(perform: viewModel.removeFolder)
        }
        .toolbar{
            Button(action: {
                showingAddFolderView = true
            }) {
                Image(systemName: "plus")
            }
            .padding()
        }
        .navigationTitle("Folders")
        .sheet(isPresented: $showingAddFolderView) {
            AddFolderView(viewModel: viewModel)
        }
    }
}

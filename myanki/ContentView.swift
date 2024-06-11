//
//  ContentView.swift
//  myanki
//
//  Created by 劉明正 on 2024/06/10.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = FolderViewModel()
    @State private var showingAddFolderView = false
    
    var body: some View {
        NavigationView {
            Sidebar(viewModel: viewModel, showingAddFolderView: $showingAddFolderView)
            Text("Select a folder to start reviewing")
                .font(.largeTitle)
                .padding()
        }
    }
}

struct Sidebar: View {
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

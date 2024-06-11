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

struct AddCardView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var question = ""
    @State private var answer = ""
    @ObservedObject var viewModel: FolderViewModel
    let folder: Folder
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Question")) {
                    TextField("Enter question", text: $question)
                }
                
                Section(header: Text("Answer")) {
                    TextField("Enter answer", text: $answer)
                }
                
                Button("Add Card") {
                    viewModel.addCard(to: folder, question: question, answer: answer)
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .navigationTitle("Add New Card")
        }
    }
}

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
                
                Button("Add Folder") {
                    viewModel.addFolder(name: folderName)
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .navigationTitle("Add New Folder")
        }
    }
}

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
            SidebarFolderView(viewModel: viewModel, showingAddFolderView: $showingAddFolderView)
            Text("Select a folder to start reviewing")
                .font(.largeTitle)
                .padding()
        }
    }
}

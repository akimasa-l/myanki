//
//  FolderDetailContainerView.swift
//  myanki
//
//  Created by 劉明正 on 2024/06/12.
//

import SwiftUI

struct FolderDetailContainerView: View {
    @ObservedObject var viewModel: FolderViewModel
    
    var body: some View {
        if let folder = viewModel.selectedFolder {
            FolderDetailView(viewModel: viewModel, folder: folder)
        } else {
            Text("Select a folder to start reviewing")
                .font(.largeTitle)
                .padding()
        }
    }
}

//
//  FolderDetailContainerView.swift
//  myanki
//
//  Created by 劉明正 on 2024/06/12.
//

import SwiftUI

struct FolderDetailContainerView: View {
    @EnvironmentObject var viewModel: FolderViewModel
    
    var body: some View {
        if let folder = viewModel.selectedFolder {
            FolderDetailView()
        } else {
            Text("Select a folder to start reviewing")
                .font(.largeTitle)
                .padding()
        }
    }
}

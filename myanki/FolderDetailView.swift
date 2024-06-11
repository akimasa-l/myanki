//
//  FolderDetailView.swift
//  myanki
//
//  Created by 劉明正 on 2024/06/11.
//

import SwiftUI

struct FolderDetailView: View {
    @ObservedObject var viewModel: FolderViewModel
    @State private var showingAddCardView = false
    @State private var showingEditFolderName = false
    @State private var newFolderName = ""
    @State private var startReview = false
    @State private var isEditingFolderName = false
    let folder: Folder
    
    var body: some View {
        VStack {
            List {
                // フォルダー名を表示
                Section(header: Text("Folder Name")) {
                    HStack {
                        Text(folder.name)
                        Spacer()
                        Button(action: {
                            newFolderName = folder.name
                            isEditingFolderName = true
                        }) {
                            Image(systemName: "pencil")
                        }
                    }
                }
                
                // カードリストを表示
                Section(header: Text("Cards")) {
                    ForEach(folder.cards) { card in
                        VStack(alignment: .leading) {
                            Text(card.question)
                                .font(.headline)
                            Text(card.answer)
                                .font(.subheadline)
                        }
                    }
                    .onDelete { offsets in
                        viewModel.removeCard(at: offsets, from: folder)
                    }
                }
            }
            .navigationTitle(folder.name)
            
            // カード追加ボタン
            Button(action: {
                showingAddCardView = true
            }) {
                Text("Add Card")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            .sheet(isPresented: $showingAddCardView) {
                AddCardView(viewModel: viewModel, folder: folder)
            }
            .sheet(isPresented: $isEditingFolderName) {
                EditFolderNameView(folderName: $newFolderName, isPresented: $isEditingFolderName) {
                    viewModel.updateFolderName(folder: folder, newName: newFolderName)
                }
            }
            
//            // フォルダー名編集シート
//            EditFolderNameView(folderName: $newFolderName, isPresented: $showingEditFolderName) {
//                viewModel.updateFolderName(folder: folder, newName: newFolderName)
//            }
            
            // レビュー開始ボタン
            Button(action: {
                startReview = true
            }) {
                Text("Start Review")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
    }
}

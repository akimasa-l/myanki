//
//  FolderDetailView.swift
//  myanki
//
//  Created by 劉明正 on 2024/06/11.
//

import SwiftUI

struct FolderDetailView: View {
    @EnvironmentObject var viewModel: FolderViewModel
    @State private var showingAddCardView = false
    @State private var showingEditCardView = false
    @State private var editingCard: Card?
    @State private var editingQuestion = ""
    @State private var editingAnswer = ""
    @State private var newFolderName = ""
    @State private var startReview = false
    @State private var isEditingFolderName = false
    //    let folder: Folder
    
    var body: some View {
        if let folder = viewModel.selectedFolder {
            VStack {
                Form {
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
                                HStack {
                                    CardDetailView(card: card)
                                    Spacer()
                                    Button(action: {
                                        editingCard = card
                                        editingQuestion = card.question
                                        editingAnswer = card.answer
                                        showingEditCardView = true
                                    }) {
                                        Image(systemName: "pencil")
                                    }
                                }
                            }
                            
                        }
                        .onDelete { offsets in
                            viewModel.removeCard(at: offsets, from: folder)
                        }
                        .onMove { source, destination in
                            viewModel.moveCard(from: source, to: destination, in: folder)
                        }
                    }
                }
                NavigationLink(destination: ReviewView(folder: folder)) {
                    Text("Start Review")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .toolbar {
                HStack{
                    Button(action: {
                        showingAddCardView = true
                    }) {
                        Image(systemName: "plus")
                    }
                    Spacer()
                    EditButton()
                }
            }
            .navigationTitle(folder.name)
            .sheet(isPresented: $isEditingFolderName) {
                EditFolderNameView(folderName: $newFolderName, isPresented: $isEditingFolderName) {
                    viewModel.updateFolderName(folder: folder, newName: newFolderName)
                }
            }
            .sheet(isPresented: $showingEditCardView) {
                if let card = editingCard {
                    EditCardView(question: $editingQuestion, answer: $editingAnswer, isPresented: $showingEditCardView) {
                        viewModel.updateCard(folder: folder, card: card, newQuestion: editingQuestion, newAnswer: editingAnswer)
                    }
                }
            }
            .sheet(isPresented: $showingAddCardView) {
                AddCardView(folder: folder)
            }
        }
    }
}


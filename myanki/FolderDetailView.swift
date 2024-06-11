//
//  FolderDetailView.swift
//  myanki
//
//  Created by 劉明正 on 2024/06/11.
//

import SwiftUI

struct FolderDetailView: View {
    @ObservedObject var viewModel: FolderViewModel
    let folder: Folder
    @State private var showingAddCardView = false
    @State private var startReview = false
    
    var body: some View {
        VStack {
            List {
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
            .navigationTitle(folder.name)
            
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
            
            NavigationLink(destination: ReviewView(viewModel: viewModel, folder: folder), isActive: $startReview) {
                EmptyView()
            }
            
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

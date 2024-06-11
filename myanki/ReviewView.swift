//
//  ReviewView.swift
//  myanki
//
//  Created by 劉明正 on 2024/06/11.
//

import SwiftUI

struct ReviewView: View {
    @ObservedObject var viewModel: FolderViewModel
    let folder: Folder
    
    var body: some View {
        VStack {
            if viewModel.allCardsReviewed {
                Text("おめでとう！！")
                    .font(.largeTitle)
                    .padding()
            } else {
                if let currentCard = viewModel.currentCard {
                    Text(viewModel.showAnswer ? currentCard.answer : currentCard.question)
                        .font(.largeTitle)
                        .padding()
                        .frame(width: 300, height: 200)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .onTapGesture {
                            viewModel.flipCard()
                        }
                    
                    HStack {
                        Button(action: {
                            viewModel.reviewCard(difficulty: "again")
                        }) {
                            Text("Again\n(\(viewModel.nextReviewTime(for: "again")))")
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .multilineTextAlignment(.center)
                        }
                        
                        Button(action: {
                            viewModel.reviewCard(difficulty: "hard")
                        }) {
                            Text("Hard\n(\(viewModel.nextReviewTime(for: "hard")))")
                                .padding()
                                .background(Color.orange)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .multilineTextAlignment(.center)
                        }
                        
                        Button(action: {
                            viewModel.reviewCard(difficulty: "good")
                        }) {
                            Text("Good\n(\(viewModel.nextReviewTime(for: "good")))")
                                .padding()
                                .background(Color.yellow)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .multilineTextAlignment(.center)
                        }
                        
                        Button(action: {
                            viewModel.reviewCard(difficulty: "easy")
                        }) {
                            Text("Easy\n(\(viewModel.nextReviewTime(for: "easy")))")
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Review")
        .onAppear {
            viewModel.currentFolderIndex = viewModel.folders.firstIndex(where: { $0.id == folder.id })
            viewModel.currentCardIndex = nil
            viewModel.nextCard()
        }
    }
}

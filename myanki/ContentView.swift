//
//  ContentView.swift
//  myanki
//
//  Created by 劉明正 on 2024/06/10.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = CardViewModel()
    @State private var showingAddCardView = false
    
    var body: some View {
        NavigationView {
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
                                    .multilineTextAlignment(.center)
                            }
                        }
                        .padding()
                    }
                }
                
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
            }
            .navigationTitle("Anki Clone")
            .sheet(isPresented: $showingAddCardView) {
                AddCardView(viewModel: viewModel)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle()) // iPadで質問がメイン画面に表示されるようにする
    }
}

struct AddCardView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var question = ""
    @State private var answer = ""
    @ObservedObject var viewModel: CardViewModel
    
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
                    viewModel.addCard(question: question, answer: answer)
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .navigationTitle("Add New Card")
        }
    }
}

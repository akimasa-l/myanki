//
//  ContentView.swift
//  myanki
//
//  Created by 劉明正 on 2024/06/10.
//

import Foundation
import SwiftUI

//struct Card {
//    let question: String
//    let answer: String
//}
//
//class CardViewModel: ObservableObject {
//    @Published var cards: [Card] = [
//        Card(question: "What is the capital of France?", answer: "Paris"),
//        Card(question: "What is 2+2?", answer: "4"),
//        // ここにさらにカードを追加できます
//    ]
//    
//    @Published var currentCardIndex: Int = 0
//    @Published var showAnswer: Bool = false
//    
//    var currentCard: Card {
//        return cards[currentCardIndex]
//    }
//    
//    func nextCard() {
//        if currentCardIndex < cards.count - 1 {
//            currentCardIndex += 1
//        } else {
//            currentCardIndex = 0
//        }
//        showAnswer = false
//    }
//    
//    func flipCard() {
//        showAnswer.toggle()
//    }
//}
//
//struct ContentView: View {
//    @StateObject var viewModel = CardViewModel()
//    
//    var body: some View {
//        VStack {
//            Text(viewModel.showAnswer ? viewModel.currentCard.answer : viewModel.currentCard.question)
//                .font(.largeTitle)
//                .padding()
//                .frame(width: 300, height: 200)
//                .background(Color.blue)
//                .foregroundColor(.white)
//                .cornerRadius(10)
//                .onTapGesture {
//                    viewModel.flipCard()
//                }
//            
//            Button(action: {
//                viewModel.nextCard()
//            }) {
//                Text("Next")
//                    .padding()
//                    .background(Color.green)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//            .padding()
//        }
//    }
//}

struct ContentView: View {
    @StateObject var viewModel = CardViewModel()
    
    var body: some View {
        VStack {
            Text(viewModel.showAnswer ? viewModel.currentCard.answer : viewModel.currentCard.question)
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
                    Text("Again")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    viewModel.reviewCard(difficulty: "hard")
                }) {
                    Text("Hard")
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    viewModel.reviewCard(difficulty: "good")
                }) {
                    Text("Good")
                        .padding()
                        .background(Color.yellow)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    viewModel.reviewCard(difficulty: "easy")
                }) {
                    Text("Easy")
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

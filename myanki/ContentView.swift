//
//  ContentView.swift
//  myanki
//
//  Created by 劉明正 on 2024/06/10.
//

import Foundation
import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = CardViewModel()
    
    var body: some View {
        VStack {
            if viewModel.allCardsReviewed {
                Text("おめでとう！！")
                    .font(.largeTitle)
                    .padding()
            } else {
                Text(viewModel.showAnswer ? viewModel.currentCard?.answer ?? "" : viewModel.currentCard?.question ?? "")
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
}

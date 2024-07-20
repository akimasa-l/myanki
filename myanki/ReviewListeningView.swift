//
//  ReviewListeningView.swift
//  myanki
//
//  Created by 山田智貴 on 2024/07/20.
//

import SwiftUI
import AVFoundation

struct ReviewListeningView: View {
    @EnvironmentObject var viewModel: FolderViewModel
    let folder: Folder
    @State var id = 0
    private let synthesizer = AVSpeechSynthesizer() // Initialize the speech synthesizer
    
    private func speakText(text: String, language: String) {
        let language = language
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: language)
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate
        synthesizer.speak(utterance)
    }
    
    @State var is_question_chinese = true
    
    var body: some View {
        VStack {
            if viewModel.allCardsReviewed {
                Text("おめでとう！！")
                    .font(.largeTitle)
                    .padding()
            } else {
                if let currentCard = viewModel.currentCard {
                    
                    Button(action: {
                        speakText(text: (currentCard.is_question_chinese ? currentCard.question : currentCard.answer), language: "zh-CN")
                    }) {
                        Image(systemName: (!currentCard.is_question_chinese) && !viewModel.showAnswer ? "speaker.slash" : "speaker.wave.2") // Use a system icon or custom image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .padding(20)
                                .foregroundStyle(.blue)
                                .background(.white)
                                .clipShape(Circle())
                                .shadow(radius: 10)
                    }
                    .disabled((!currentCard.is_question_chinese) && !viewModel.showAnswer)
                    .frame(width: 120, height: 120)
                    
                    Text(currentCard.is_question_chinese ? (viewModel.showAnswer ? "Q: " + currentCard.question + "\nA: " + currentCard.answer : "reveal an answer") : (viewModel.showAnswer ? "A: " + currentCard.answer : "Q: " + currentCard.question))
                        .font(.largeTitle)
                        .padding()
                        .frame(width: 300, height: 200)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .onTapGesture {
                            viewModel.flipCard()
                        }
                    
                    PenKitView()
                        .frame(width: 500, height: 200)
                        .border(Color.black)
                        .id(id)
                    
                    HStack {
                        Button(action: {
                            viewModel.reviewCard(difficulty: "again")
                            id+=1
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
                            id+=1
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
                            id+=1
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
                            id+=1
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
//            viewModel.currentCardIndex = nil
            viewModel.nextCard()
        }
    }
}


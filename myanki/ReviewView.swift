//
//  ReviewView.swift
//  myanki
//
//  Created by 劉明正 on 2024/06/11.
//

import SwiftUI
import AVFoundation

func fayin(str: String, synthesizer: AVSpeechSynthesizer){
    let f=str.components(separatedBy: " ")
    if f.count == 1 || f.count == 2{
        let text = AVSpeechUtterance(string: f[0])
        let language = AVSpeechSynthesisVoice(language: "zh-CN")
        text.voice = language
        synthesizer.speak(text)
    }
}

struct ReviewView: View {
    @EnvironmentObject var viewModel: FolderViewModel
    let synthesizer = AVSpeechSynthesizer()
    let folder: Folder
    @State var id = 0
    
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
                        .font(.custom("STKaiti",size:20)) // フォント変わんないんだけどなんで？？
                        .padding()
                        .frame(width: 300, height: 200)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .onTapGesture {
                            viewModel.flipCard()
                            if viewModel.showAnswer{
                                fayin(str: currentCard.answer, synthesizer: synthesizer)
                            }
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

//
//  viewmodel.swift
//  myanki
//
//  Created by 劉明正 on 2024/06/10.
//

import Foundation
class CardViewModel: ObservableObject {
    @Published var cards: [Card] = [
        Card(question: "What is the capital of France?", answer: "Paris", nextReviewDate: Date(), interval: 0),
        Card(question: "What is 2+2?", answer: "4", nextReviewDate: Date(), interval: 0),
        // ここにさらにカードを追加できます
    ]
    
    @Published var currentCardIndex: Int = 0
    @Published var showAnswer: Bool = false
    
    var currentCard: Card {
        return cards[currentCardIndex]
    }
    
    func nextCard() {
        let now = Date()
        if let nextIndex = cards.enumerated().filter({ $0.element.nextReviewDate <= now }).map({ $0.offset }).first {
            currentCardIndex = nextIndex
        } else {
            currentCardIndex = 0
        }
        showAnswer = false
    }
    
    func flipCard() {
        showAnswer.toggle()
    }
    
    func reviewCard(difficulty: String) {
        let now = Date()
        var newInterval: TimeInterval
        
        switch difficulty {
        case "easy":
            newInterval = currentCard.interval == 0 ? 60 * 60 : currentCard.interval * 2 // 初回1時間、その後倍増
        case "good":
            newInterval = currentCard.interval == 0 ? 30 * 60 : currentCard.interval * 1.5 // 初回30分、その後1.5倍
        case "hard":
            newInterval = currentCard.interval == 0 ? 10 * 60 : currentCard.interval // 初回10分、その後同じ間隔
        case "again":
            newInterval = 1 * 60 // 再学習は1分後
        default:
            newInterval = currentCard.interval
        }
        
        cards[currentCardIndex].interval = newInterval
        cards[currentCardIndex].nextReviewDate = now.addingTimeInterval(newInterval)
        
        nextCard()
    }
}

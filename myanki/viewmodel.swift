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
    @Published var allCardsReviewed: Bool = false  // 全てのカードがレビューされたかどうかを保持
    
    var currentCard: Card? {
        if cards.isEmpty {
            return nil
        }
        return cards[currentCardIndex]
    }
    
    func nextCard() {
        let now = Date()
        if let nextIndex = cards.enumerated().filter({ $0.element.nextReviewDate <= now }).map({ $0.offset }).first {
            currentCardIndex = nextIndex
            showAnswer = false
            allCardsReviewed = false  // 次のカードが見つかったのでフラグをリセット
        } else {
            allCardsReviewed = true  // 次のカードが見つからなかった場合
        }
    }
    
    func flipCard() {
        showAnswer.toggle()
    }
    
    func reviewCard(difficulty: String) {
        let now = Date()
        var newInterval: TimeInterval
        
        switch difficulty {
        case "easy":
            newInterval = currentCard?.interval == 0 ? 60 * 60 : currentCard!.interval * 2
        case "good":
            newInterval = currentCard?.interval == 0 ? 30 * 60 : currentCard!.interval * 1.5
        case "hard":
            newInterval = currentCard?.interval == 0 ? 10 * 60 : currentCard!.interval
        case "again":
            newInterval = 1 * 60
        default:
            newInterval = currentCard?.interval ?? 0
        }
        
        if let index = currentCardIndex as Int? {
            cards[index].interval = newInterval
            cards[index].nextReviewDate = now.addingTimeInterval(newInterval)
        }
        
        nextCard()
    }
}

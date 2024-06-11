//
//  CardViewModel.swift
//  myanki
//
//  Created by 劉明正 on 2024/06/10.
//

import Foundation
import SwiftUI

class CardViewModel: ObservableObject {
    @Published var cards: [Card] = []
    @Published var currentCardIndex: Int?
    @Published var showAnswer: Bool = false
    @Published var allCardsReviewed: Bool = false
    
    private let saveKey = "cards"
    
    init() {
        loadCards()
        nextCard()
    }
    
    var currentCard: Card? {
        if let currentCardIndex = currentCardIndex, cards.indices.contains(currentCardIndex) {
            return cards[currentCardIndex]
        }
        return nil
    }
    
    func nextCard() {
        let now = Date()
        let dueCards = cards.filter { $0.nextReviewDate <= now }
        
        if let nextIndex = dueCards.isEmpty ? nil : cards.firstIndex(of: dueCards.first!) {
            currentCardIndex = nextIndex
            showAnswer = false
            allCardsReviewed = false
        } else {
            allCardsReviewed = true
            currentCardIndex = nil
        }
    }
    
    func flipCard() {
        showAnswer.toggle()
    }
    
    func reviewCard(difficulty: String) {
        guard let currentCardIndex = currentCardIndex else { return }
        
        let now = Date()
        var newInterval: TimeInterval
        
        switch difficulty {
        case "easy":
            newInterval = cards[currentCardIndex].interval == 0 ? 60 * 60 : cards[currentCardIndex].interval * 2
        case "good":
            newInterval = cards[currentCardIndex].interval == 0 ? 30 * 60 : cards[currentCardIndex].interval * 1.5
        case "hard":
            newInterval = cards[currentCardIndex].interval == 0 ? 10 * 60 : cards[currentCardIndex].interval
        case "again":
            newInterval = 1 * 60
        default:
            newInterval = cards[currentCardIndex].interval
        }
        
        cards[currentCardIndex].interval = newInterval
        cards[currentCardIndex].nextReviewDate = now.addingTimeInterval(newInterval)
        
        saveCards()
        nextCard()
    }
    
    func nextReviewTime(for difficulty: String) -> String {
        guard let currentCard = currentCard else { return "0分後" }
        
        var interval: TimeInterval
        
        switch difficulty {
        case "easy":
            interval = currentCard.interval == 0 ? 60 * 60 : currentCard.interval * 2
        case "good":
            interval = currentCard.interval == 0 ? 30 * 60 : currentCard.interval * 1.5
        case "hard":
            interval = currentCard.interval == 0 ? 10 * 60 : currentCard.interval
        case "again":
            interval = 1 * 60
        default:
            interval = currentCard.interval
        }
        
        let minutes = interval / 60
        return "\(Int(minutes))分後"
    }
    
    func addCard(question: String, answer: String) {
        let newCard = Card(question: question, answer: answer)
        cards.append(newCard)
        saveCards()
    }
    
    func removeCard(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        saveCards()
    }
    
    private func saveCards() {
        if let data = try? JSONEncoder().encode(cards) {
            UserDefaults.standard.set(data, forKey: saveKey)
        }
    }
    
    private func loadCards() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let savedCards = try? JSONDecoder().decode([Card].self, from: data) {
            cards = savedCards
        }
    }
}

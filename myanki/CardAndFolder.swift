//
//  CardAndFolder.swift
//  myanki
//
//  Created by 劉明正 on 2024/06/10.
//

import Foundation

struct Card: Identifiable, Codable, Equatable, Hashable {
    let id: UUID
    var question: String
    var answer: String
    var nextReviewDate: Date
    var incorrectCount: Int = 0
    var interval: TimeInterval
    var is_question_chinese: Bool
    
    init(id: UUID = UUID(), question: String, answer: String, nextReviewDate: Date = Date(), interval: TimeInterval = 0, is_question_chinese: Bool = true) {
        self.id = id
        self.question = question
        self.answer = answer
        self.nextReviewDate = nextReviewDate
        self.interval = interval
        self.is_question_chinese = is_question_chinese
    }
}

struct Folder: Identifiable, Codable, Equatable, Hashable {
    let id: UUID
    var name: String
    var cards: [Card]
    
    init(id: UUID = UUID(), name: String, cards: [Card] = []) {
        self.id = id
        self.name = name
        self.cards = cards
    }
}

//
//  card.swift
//  myanki
//
//  Created by 劉明正 on 2024/06/10.
//

import Foundation

struct Card {
    let question: String
    let answer: String
    var nextReviewDate: Date
    var interval: TimeInterval // 間隔を保持
}

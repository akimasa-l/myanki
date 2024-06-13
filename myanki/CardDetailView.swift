//
//  CardDetailView.swift
//  myanki
//
//  Created by 劉明正 on 2024/06/13.
//

import SwiftUI

struct CardDetailView: View {
    let card: Card
    var body: some View {
        VStack(alignment: .leading) {
            Text(card.question)
                .font(.headline)
            Text(card.answer)
                .font(.subheadline)
        }
//        Text("Incorrect attempts: \(card.incorrectCount)")
//            .font(.caption)
//            .foregroundColor(.red)
//        
//        Text("\(card.nextReviewDate)")
    }
}

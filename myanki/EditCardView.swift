//
//  EditCardView.swift
//  myanki
//
//  Created by 劉明正 on 2024/06/11.
//

import SwiftUI

struct EditCardView: View {
    @Binding var question: String
    @Binding var answer: String
    @Binding var isPresented: Bool
    var onCommit: () -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Edit Question")) {
                    TextField("Question", text: $question)
                }
                
                Section(header: Text("Edit Answer")) {
                    TextField("Answer", text: $answer)
                }
            }
            .navigationTitle("Edit Card")
            .navigationBarItems(trailing: Button("Done") {
                isPresented = false
                onCommit()
            })
        }
    }
}

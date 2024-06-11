//
//  AddCardView.swift
//  myanki
//
//  Created by 劉明正 on 2024/06/11.
//

import SwiftUI

struct AddCardView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var question = ""
    @State private var answer = ""
    @ObservedObject var viewModel: FolderViewModel
    let folder: Folder
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Question")) {
                    TextField("Enter question", text: $question)
                }
                
                Section(header: Text("Answer")) {
                    TextField("Enter answer", text: $answer)
                }
            }
            .navigationTitle("Add New Card")
            .navigationBarItems(trailing: Button("Done") {
                viewModel.addCard(to: folder, question: question, answer: answer)
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

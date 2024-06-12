//
//  CSVConfirmationView.swift
//  myanki
//
//  Created by 劉明正 on 2024/06/12.
//

import SwiftUI

struct CSVConfirmationView: View {
    @ObservedObject var viewModel: FolderViewModel
    let folder: Folder
    @Binding var csvText: String
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            List {
                let lines = csvText.split(separator: "\n")
                ForEach(lines, id: \.self) { line in
                    let components = line.split(separator: ",")
                    if components.count == 2 {
                        let question = String(components[0]).trimmingCharacters(in: .whitespacesAndNewlines)
                        let answer = String(components[1]).trimmingCharacters(in: .whitespacesAndNewlines)
                        VStack(alignment: .leading) {
                            Text("Q: \(question)")
                                .font(.headline)
                            Text("A: \(answer)")
                                .font(.subheadline)
                        }
                    }
                }
            }
            .navigationTitle("Confirm CSV Data")
            .navigationBarItems(trailing: Button("Add Cards") {
                viewModel.addCardsFromCSV(to: folder, csvString: csvText)
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

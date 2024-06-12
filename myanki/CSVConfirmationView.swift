//
//  CSVConfirmationView.swift
//  myanki
//
//  Created by 劉明正 on 2024/06/12.
//

import SwiftUI

struct CSVConfirmationView: View {
    @EnvironmentObject var viewModel: FolderViewModel
    let folder: Folder
    @Binding var csvText: String
    @Binding var lineSeparator: String
    @Binding var fieldSeparator: String
    @Binding var swapQA: Bool
    var dismiss:DismissAction
    
    var body: some View {
        VStack {
            List {
                let lines = csvText.components(separatedBy: convertEscapedString(lineSeparator))
                ForEach(lines, id: \.self) { line in
                    let components = line.components(separatedBy: convertEscapedString(fieldSeparator))
                    if components.count == 2 {
                        let question = String(components[0]).trimmingCharacters(in: .whitespacesAndNewlines)
                        let answer = String(components[1]).trimmingCharacters(in: .whitespacesAndNewlines)
                        VStack(alignment: .leading) {
                            if swapQA {
                                Text("Q: \(answer)")
                                    .font(.headline)
                                Text("A: \(question)")
                                    .font(.subheadline)
                            } else {
                                Text("Q: \(question)")
                                    .font(.headline)
                                Text("A: \(answer)")
                                    .font(.subheadline)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Confirm CSV Data")
            .navigationBarItems(trailing: Button("Add Cards") {
                viewModel.addCardsFromCSV(to: folder, csvString: csvText, lineSeparator: lineSeparator, fieldSeparator: fieldSeparator, swapQA: swapQA)
                dismiss()
            })
        }
    }
}

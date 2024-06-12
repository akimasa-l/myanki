//
//  FolderViewModel.swift
//  myanki
//
//  Created by 劉明正 on 2024/06/10.
//

import Foundation
import SwiftUI

class FolderViewModel: ObservableObject {
    @Published var folders: [Folder] = []
    @Published var currentFolderIndex: Int?
    @Published var currentCardIndex: Int?
    @Published var showAnswer: Bool = false
    @Published var allCardsReviewed: Bool = false
//    @Published var selectedFolder: Folder?

    
    private let saveKey = "folders"
    
    init() {
        loadFolders()
    }
    
    var currentCard: Card? {
        if let currentFolderIndex = currentFolderIndex, folders.indices.contains(currentFolderIndex),
           let currentCardIndex = currentCardIndex, folders[currentFolderIndex].cards.indices.contains(currentCardIndex) {
            return folders[currentFolderIndex].cards[currentCardIndex]
        }
        return nil
    }
    
    func nextCard() {
        //        print("nextCard呼ばれてる")
        guard let currentFolderIndex = currentFolderIndex else {
            //            print("currentFolderIndexない")
            return
        }
        //        print("currentFolderIndexある")
        let now = Date()
        let dueCards = folders[currentFolderIndex].cards.filter { $0.nextReviewDate <= now }
        
        if let nextIndex = dueCards.isEmpty ? nil : folders[currentFolderIndex].cards.firstIndex(of: dueCards.first!) {
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
        guard let currentFolderIndex = currentFolderIndex, let currentCardIndex = currentCardIndex else { return }
        
        let now = Date()
        var newInterval: TimeInterval
        
        switch difficulty {
        case "easy":
            newInterval = folders[currentFolderIndex].cards[currentCardIndex].interval == 0 ? 60 * 60 : folders[currentFolderIndex].cards[currentCardIndex].interval * 2
        case "good":
            newInterval = folders[currentFolderIndex].cards[currentCardIndex].interval == 0 ? 30 * 60 : folders[currentFolderIndex].cards[currentCardIndex].interval * 1.5
        case "hard":
            newInterval = folders[currentFolderIndex].cards[currentCardIndex].interval == 0 ? 10 * 60 : folders[currentFolderIndex].cards[currentCardIndex].interval
        case "again":
            newInterval = 1 * 60
        default:
            newInterval = folders[currentFolderIndex].cards[currentCardIndex].interval
        }
        
        folders[currentFolderIndex].cards[currentCardIndex].interval = newInterval
        folders[currentFolderIndex].cards[currentCardIndex].nextReviewDate = now.addingTimeInterval(newInterval)
        
        saveFolders()
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
    
    func addCard(to folder: Folder, question: String, answer: String) {
        if let index = folders.firstIndex(where: { $0.id == folder.id }) {
            let newCard = Card(question: question, answer: answer)
            folders[index].cards.append(newCard)
            saveFolders()
        }
    }
    
    func removeCard(at offsets: IndexSet, from folder: Folder) {
        if let index = folders.firstIndex(where: { $0.id == folder.id }) {
            folders[index].cards.remove(atOffsets: offsets)
            saveFolders()
        }
    }
    
    func addFolder(name: String) {
        let newFolder = Folder(name: name)
        folders.append(newFolder)
        saveFolders()
    }
    
    func removeFolder(at offsets: IndexSet) {
        folders.remove(atOffsets: offsets)
        saveFolders()
    }
    
    private func saveFolders() {
        if let data = try? JSONEncoder().encode(folders) {
            UserDefaults.standard.set(data, forKey: saveKey)
        }
    }
    
    private func loadFolders() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let savedFolders = try? JSONDecoder().decode([Folder].self, from: data) {
            folders = savedFolders
        }
    }
    
    func updateFolderName(folder: Folder, newName: String) {
        if let index = folders.firstIndex(where: { $0.id == folder.id }) {
            folders[index].name = newName
            saveFolders()
        }
    }
    
    func moveCard(from source: IndexSet, to destination: Int, in folder: Folder) {
        if let index = folders.firstIndex(where: { $0.id == folder.id }) {
            folders[index].cards.move(fromOffsets: source, toOffset: destination)
            saveFolders()
        }
    }
    
    func updateCard(folder: Folder, card: Card, newQuestion: String, newAnswer: String) {
        if let folderIndex = folders.firstIndex(where: { $0.id == folder.id }),
           let cardIndex = folders[folderIndex].cards.firstIndex(where: { $0.id == card.id }) {
            folders[folderIndex].cards[cardIndex].question = newQuestion
            folders[folderIndex].cards[cardIndex].answer = newAnswer
            saveFolders()
        }
    }
    
    func addCardsFromCSV(to folder: Folder, csvString: String, lineSeparator: String, fieldSeparator: String, swapQA: Bool) {
        let lines = csvString.components(separatedBy: convertEscapedString(lineSeparator))
        print(lines)
        for line in lines {
            let components = line.components(separatedBy: convertEscapedString(fieldSeparator))
            print(components)
            if components.count == 2 {
                let question = components[0].trimmingCharacters(in: .whitespacesAndNewlines)
                let answer = components[1].trimmingCharacters(in: .whitespacesAndNewlines)
                if swapQA {
                    addCard(to: folder, question: answer, answer: question)
                } else {
                    addCard(to: folder, question: question, answer: answer)
                }
            }
        }
    }
}

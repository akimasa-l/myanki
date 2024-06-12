//
//  myankiApp.swift
//  myanki
//
//  Created by 劉明正 on 2024/06/10.
//

import SwiftUI

@main
struct myankiApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(FolderViewModel())
        }
    }
}

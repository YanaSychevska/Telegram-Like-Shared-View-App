//
//  TelegramLikeSharedViewApp.swift
//  TelegramLikeSharedView
//
//  Created by Yana Sychevska on 7/31/24.
//

import SwiftUI
import SwiftData

@main
struct TelegramLikeSharedViewApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: SharedText.self)
    }
}

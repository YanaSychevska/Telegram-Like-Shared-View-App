//
//  ContentView.swift
//  TelegramLikeSharedView
//
//  Created by Yana Sychevska on 7/31/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var sharedText: [SharedText]
    
    var body: some View {
        VStack {
            List {
                ForEach(sharedText, id: \.self) { text in
                    Text(text.text)
                }
            }
            .listStyle(.plain)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

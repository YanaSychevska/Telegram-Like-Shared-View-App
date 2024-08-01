//
//  ShareView.swift
//  Share
//
//  Created by Yana Sychevska on 7/31/24.
//

import SwiftUI
import SwiftData

struct ShareView: View {
    let sharedText: String
    var onDismiss: () -> Void
    
    var body: some View {
        VStack {
            VStack(spacing: 40) {
                VStack {
                    Text("Telegram-like Shared View")
                        .font(.system(.title2))
                    Text("by Yana Sychevska")
                }
                Text(sharedText)
            }
            .font(.system(size: 16))
            .frame(maxWidth: .infinity)
            .padding(40)
            .background(.white)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 12, height: 12), style: .continuous))
            
            Button {
                Task {
                    await saveWord()
                    onDismiss()
                }
            } label: {
                Text("Save")
            }
            .frame(maxWidth: .infinity)
            .fontWeight(.bold)
            .padding(.vertical, 16)
            .background(.white)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 12, height: 12), style: .continuous))

            Button {
                onDismiss()
            } label: {
                Text("Cancel")
            }
            .frame(maxWidth: .infinity)
            .fontWeight(.bold)
            .padding(.vertical, 16)
            .background(.white)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 12, height: 12), style: .continuous))
        }
        .font(.system(size: 20))
        .foregroundStyle(.black)
    }
    
    func saveWord() async {
        do {
            let context = try ModelContext(.init(for: SharedText.self))
            let sharedText = SharedText(text: sharedText)
            context.insert(sharedText)
            try context.save()
        } catch {
            print("Failed to save: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ShareView(sharedText: "Text", onDismiss: {})
}


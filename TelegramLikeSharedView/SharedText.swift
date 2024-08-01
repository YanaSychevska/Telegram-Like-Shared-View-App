//
//  SharedText.swift
//  TelegramLikeSharedView
//
//  Created by Yana Sychevska on 7/31/24.
//

import Foundation
import SwiftData

@Model
class SharedText {
    var text: String
    
    init(text: String) {
        self.text = text
    }
}

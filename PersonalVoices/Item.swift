//
//  Item.swift
//  PersonalVoices
//
//  Created by Evan Anger on 12/8/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}

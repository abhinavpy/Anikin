//
//  GearItem.swift
//  Anikin
//
//  Created by Abhinav Prasad Yasaswi on 2/8/26.
//
import Foundation
import SwiftData

@Model
final class GearItem {
    var name: String
    var category: String // Mask, Tail, Accessory, Jewelry
    var dateAcquired: Date
    var imageData: Data? // Stores the photo locally
    var isFavorite: Bool
    
    init(name: String, category: String, dateAcquired: Date = .now, isFavorite: Bool = false) {
        self.name = name
        self.category = category
        self.dateAcquired = dateAcquired
        self.isFavorite = isFavorite
    }
}

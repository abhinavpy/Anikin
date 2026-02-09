//
//  Theriotype.swift
//  Anikin
//
//  Created by Abhinav Prasad Yasaswi on 1/21/26.
//

import Foundation
import SwiftData

@Model
final class Theriotype: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var category: String // e.g., Feline, Canine, Avian, Mythical
    var icon: String     // SF Symbol name
    var species: String
    var nickname: String
    
    // This tells SwiftData that one Theriotype can have many ShiftLogs
    @Relationship(deleteRule: .cascade, inverse: \ShiftLog.theriotype)
    var logs: [ShiftLog] = []
    
    init(name: String, category: String, icon: String, species: String, nickname: String) {
        self.name = name
        self.category = category
        self.icon = icon
        self.species = species
        self.nickname = nickname
    }
}

// Mock data for the selection grid
class TheriotypeData {
    static var species = [
        Theriotype(name: "Wolf", category: "Canine", icon: "pawprint.fill", species: "Canis lupus", nickname: "Lupus"),
        Theriotype(name: "Red Fox", category: "Canine", icon: "flame.fill", species: "Vulpes vulpes", nickname: "Fox"),
        Theriotype(name: "Lynx", category: "Feline", icon: "cat.fill", species: "Lynx lynx", nickname: "Lynx"),
        Theriotype(name: "Crow", category: "Avian", icon: "bird.fill", species: "Corvus corone", nickname: "Crow"),
        Theriotype(name: "Dragon", category: "Mythical", icon: "sparkles", species: "Draco", nickname: "Dragon"),
        Theriotype(name: "Other", category: "Custom", icon: "questionmark.circle", species: "Unknown", nickname: "Other")
    ]
}

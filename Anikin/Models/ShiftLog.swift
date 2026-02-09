//
//  ShiftLog.swift
//  Anikin
//
//  Created by Abhinav Prasad Yasaswi on 2/8/26.
//

import Foundation
import SwiftData

@Model
final class ShiftLog {
    // Unique identifier for each log
    @Attribute(.unique) var id: UUID = UUID()
    
    // Core data points
    var timestamp: Date
    var type: String       // e.g., "Phantom", "Mental", "Sensory"
    var intensity: Int     // 1 to 5
    var note: String
    
    // Optional metadata for a "Therian Journal"
    var weatherCondition: String?
    var trigger: String?
    
    // Relationship: Links the log to a specific Theriotype
    // If you delete a theriotype, you might want to keep the logs (nullify)
    // or delete them (cascade).
    var theriotype: Theriotype?

    init(
        timestamp: Date = .now,
        type: String = "Mental",
        intensity: Int = 3,
        note: String = "",
        weatherCondition: String? = nil,
        trigger: String? = nil
    ) {
        self.id = UUID()
        self.timestamp = timestamp
        self.type = type
        self.intensity = intensity
        self.note = note
        self.weatherCondition = weatherCondition
        self.trigger = trigger
    }
}

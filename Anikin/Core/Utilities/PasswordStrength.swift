//
//  PasswordStrength.swift
//  Anikin
//
//  Created by Abhinav Prasad Yasaswi on 1/21/26.
//

import Foundation
import SwiftUI

enum PasswordStrength: String {
    case weak = "Frail"
    case medium = "Growing"
    case strong = "Ancient" // Fits the Anikin forest theme
    
    var color: Color {
        switch self {
        case .weak: return .red
        case .medium: return .orange
        case .strong: return .anikinSecondary // Your forest green
        }
    }
    
    var widthMultiplier: CGFloat {
        switch self {
        case .weak: return 0.3
        case .medium: return 0.6
        case .strong: return 1.0
        }
    }
}

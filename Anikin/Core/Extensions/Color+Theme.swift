//
//  Color+Theme.swift
//  Anikin
//
//  Created by Abhinav Prasad Yasaswi on 1/21/26.
//

import SwiftUI

extension Color {
    // Your existing colors
    static let anikinBase = Color("ForestBackground")
    static let anikinSecondary = Color("SageSecondary")
    static let anikinAccent = Color("AntlerAccent")
    static let anikinText = Color("ParchmentText")
    static let anikinForestGlow = Color("ForestGlow")
    
    // --- Liquid Glass Additions ---
    
    /// Used for the subtle "rim light" on the edge of glass cards
    static let glassGlint = Color.white.opacity(0.25)
    
    /// Used for deep shadows to give glass physical elevation
    static let glassShadow = Color.black.opacity(0.3)
    
    /// A soft, glowing green for active glass elements
    static let glassAccentGlow = Color("AntlerAccent").opacity(0.15)
}

extension ShapeStyle where Self == Color {
    static var anikinBase: Color { .anikinBase }
    static var anikinSecondary: Color { .anikinSecondary }
    static var anikinAccent: Color { .anikinAccent }
    static var anikinText: Color { .anikinText }
    static var glassGlint: Color { .glassGlint }
    static var anikinForestGlow: Color { .anikinForestGlow }
}

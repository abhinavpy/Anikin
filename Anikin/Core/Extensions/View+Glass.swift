//
//  View+Glass.swift
//  Anikin
//
//  Created by Abhinav Prasad Yasaswi on 2/9/26.
//
import Foundation
import SwiftUI

extension View {
    /// Applies the 2026 "Liquid Glass" effect to any container
    func liquidGlass(cornerRadius: CGFloat = 24) -> some View {
        self
            .background(.ultraThinMaterial) // Apple's native glass blur
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .overlay(
                // The "Rim Light" - This creates the sharp glass edge
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(
                        LinearGradient(
                            colors: [.glassGlint, .clear, .white.opacity(0.1)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1.5
                    )
            )
            .shadow(color: .glassShadow, radius: 10, x: 0, y: 10)
    }
}

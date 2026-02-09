//
//  DailyInstinctCard.swift
//  Anikin
//
//  Created by Abhinav Prasad Yasaswi on 2/9/26.
//

import SwiftUI

struct DailyInstinctCard: View {
    // Shared logic for the daily quote
    let instincts = [
        "Listen to the wind; what is it telling you about the season?",
        "Your instincts are a gift. Trust your intuition today.",
        "Find a moment of silence in nature, even if it's just looking out a window.",
        "Today, move with the grace of your theriotype.",
        "The forest doesn't hurry, yet everything is accomplished."
    ]
    
    var dailyQuote: String {
        let dayOfYear = Calendar.current.ordinality(of: .day, in: .year, for: .now) ?? 0
        return instincts[dayOfYear % instincts.count]
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Label("DAILY INSTINCT", systemImage: "sparkles")
                    .font(.system(size: 10, weight: .black))
                    .foregroundStyle(.anikinAccent)
                    .kerning(1.2)
                Spacer()
            }
            
            Text(dailyQuote)
                .font(.system(size: 20, weight: .medium, design: .serif))
                .italic()
                .foregroundStyle(.white)
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(24)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 32, style: .continuous)
                .stroke(
                    LinearGradient(colors: [.white.opacity(0.3), .clear], startPoint: .topLeading, endPoint: .bottomTrailing),
                    lineWidth: 1.5
                )
        )
        .shadow(color: .black.opacity(0.2), radius: 15, x: 0, y: 10)
    }
}

//
//  OnboardingStep.swift
//  Anikin
//
//  Created by Abhinav Prasad Yasaswi on 1/21/26.
//

import Foundation
// We use 'Identifiable' so SwiftUI knows exactly which step is which
struct OnboardingStep: Identifiable {
    let id = UUID() // Generates a unique ID automatically
    let image: String
    let title: String
    let description: String
}

// This is where we create the actual content for the onboarding
struct OnboardingData {
    static let steps = [
        OnboardingStep(
            image: "leaf.fill",
            title: "Welcome to Anikin",
            description: "Your digital den for expressing your true self in a safe, nature-focused community."
        ),
        OnboardingStep(
            image: "pawprint.fill",
            title: "Embrace Your Identity",
            description: "Whether you're a Therian, Otherkin, or questioning, this is the space to share your shifts and gear."
        ),
        OnboardingStep(
            image: "shield.fill",
            title: "A Safe Habitat",
            description: "We prioritize safety and kindness. By entering, you agree to keep the forest respectful for everyone."
        )
    ]
}

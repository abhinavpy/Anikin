//
//  OnboardingView.swift
//  Anikin
//
//  Created by Abhinav Prasad Yasaswi on 1/21/26.
//

import SwiftUI

struct OnboardingView: View {
    @State private var currentStep = 0
    @EnvironmentObject var session: SessionStore

    var body: some View {
        ZStack {
            // Use your solid base color
            Color.anikinBase
                .ignoresSafeArea()
            
            VStack {
                onboardingContent
                actionButton
            }
        }
    }

    // --- Sub-Views (Breaking up the expression) ---

    private var onboardingContent: some View {
        TabView(selection: $currentStep) {
            ForEach(0..<OnboardingData.steps.count, id: \.self) { index in
                OnboardingCardView(step: OnboardingData.steps[index], currentStep: currentStep)
                    .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
    }

    private var actionButton: some View {
        Button(action: {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                if currentStep < OnboardingData.steps.count - 1 {
                    currentStep += 1
                } else {
                    session.completeOnboarding()
                }
            }
        }) {
            Text(currentStep == OnboardingData.steps.count - 1 ? "Enter the Den" : "Continue")
                .font(.headline)
                .foregroundStyle(.black)
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(Capsule().fill(.anikinAccent))
                .padding(.horizontal, 40)
                .padding(.bottom, 30)
        }
    }
}

// Separate component for the Card to help the compiler
struct OnboardingCardView: View {
    let step: OnboardingStep
    let currentStep: Int
    
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: step.image)
                .font(.system(size: 80))
                .foregroundStyle(.linearGradient(colors: [.anikinAccent, .anikinSecondary], startPoint: .topLeading, endPoint: .bottomTrailing))
                .shadow(color: .anikinAccent.opacity(0.3), radius: 10)
            
            Text(step.title)
                .font(.system(size: 34, weight: .black, design: .rounded))
                .foregroundStyle(.white)
            
            Text(step.description)
                .font(.title3)
                .multilineTextAlignment(.center)
                .foregroundStyle(.white.opacity(0.8))
                .padding(.horizontal)
        }
        .padding(40)
        .background(
            RoundedRectangle(cornerRadius: 40)
                .fill(.ultraThinMaterial) // This creates the "Glass" look on top of the solid green
                .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
        )        .cornerRadius(40)
        .overlay(RoundedRectangle(cornerRadius: 40).stroke(.white.opacity(0.1), lineWidth: 1))
        .padding(20)
    }
}

#Preview {
    OnboardingView().environmentObject(SessionStore())
}


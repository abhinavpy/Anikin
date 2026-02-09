//
//  FinalAuthView.swift
//  Anikin
//
//  Created by Abhinav Prasad Yasaswi on 1/21/26.
//

import SwiftUI

struct FinalWelcomeView: View {
    @EnvironmentObject var session: SessionStore
    let username: String
    let theriotypeName: String
    
    @State private var showContent = false
    
    var body: some View {
        ZStack {
            Color.anikinBase.ignoresSafeArea()
            
            VStack(spacing: 40) {
                Spacer()
                
                // 1. Animated Success Icon
                ZStack {
                    Circle()
                        .fill(Color.anikinAccent.opacity(0.2))
                        .frame(width: 150, height: 150)
                        .blur(radius: 20)
                    
                    Image(systemName: "leaf.fill")
                        .font(.system(size: 80))
                        .foregroundStyle(Color.anikinAccent)
                        .symbolEffect(.bounce, value: showContent)
                }
                .scaleEffect(showContent ? 1.0 : 0.5)
                .opacity(showContent ? 1.0 : 0.0)
                
                // 2. Identity Glass Card
                VStack(spacing: 15) {
                    Text("Welcome Home,")
                        .font(.title2)
                        .foregroundStyle(.white.opacity(0.7))
                    
                    Text(username)
                        .font(.system(size: 40, weight: .black, design: .rounded))
                        .foregroundStyle(.white)
                    
                    Divider()
                        .background(.white.opacity(0.2))
                        .padding(.horizontal, 40)
                    
                    Text("Your journey as a \(theriotypeName) begins now.")
                        .font(.headline)
                        .foregroundStyle(.anikinSecondary)
                        .multilineTextAlignment(.center)
                }
                .padding(30)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .stroke(.white.opacity(0.1), lineWidth: 1)
                )
                .padding(.horizontal, 20)
                .offset(y: showContent ? 0 : 50)
                .opacity(showContent ? 1.0 : 0.0)
                
                Spacer()
                
                // 3. Final Call to Action
                Button(action: {
                    withAnimation(.spring()) {
                        //isOnboarding = false
                        session.completeProfile()// This triggers the switch to the Main App
                    }
                }) {
                    Text("Enter the Den")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.glassProminent)
                .tint(.anikinAccent)
                .padding(.horizontal, 40)
                .padding(.bottom, 40)
                .opacity(showContent ? 1.0 : 0.0)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.8, dampingFraction: 0.7).delay(0.2)) {
                showContent = true
            }
        }
    }
}

#Preview {
    FinalWelcomeView(username: "SilverPaw", theriotypeName: "Wolf").environmentObject(SessionStore())
}

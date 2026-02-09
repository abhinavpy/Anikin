//
//  SecuritySetupView.swift
//  Anikin
//
//  Created by Abhinav Prasad Yasaswi on 1/21/26.
//

import SwiftUI

struct SecuritySetupView: View {
    @State private var password = ""
    @State private var isPasswordVisible = false
    
    // Logic to determine strength
    private var strength: PasswordStrength {
        if password.count < 6 { return .weak }
        if password.count < 10 { return .medium }
        return .strong
    }

    var body: some View {
        ZStack {
            Color.anikinBase.ignoresSafeArea()
            
            VStack(spacing: 30) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text("Secure Your Spirit")
                        .font(.system(size: 32, weight: .black, design: .rounded))
                        .foregroundStyle(.white)
                    Text("Choose a password to protect your den.")
                        .foregroundStyle(.white.opacity(0.6))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)

                // Password Input Section
                GlassEffectContainer {
                    VStack(alignment: .leading, spacing: 15) {
                        HStack {
                            Image(systemName: "lock.shield.fill")
                                .foregroundStyle(.anikinAccent)
                            
                            if isPasswordVisible {
                                TextField("Password", text: $password)
                            } else {
                                SecureField("Password", text: $password)
                            }
                            
                            Button(action: { isPasswordVisible.toggle() }) {
                                Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundStyle(.white.opacity(0.5))
                            }
                        }
                        .padding()
                        .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 18))

                        // Strength Meter
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("Strength:")
                                    .font(.caption).bold()
                                    .foregroundStyle(.white.opacity(0.7))
                                Text(strength.rawValue)
                                    .font(.caption).bold()
                                    .foregroundStyle(strength.color)
                            }
                            
                            // The "Liquid" Progress Bar
                            GeometryReader { geo in
                                ZStack(alignment: .leading) {
                                    Capsule()
                                        .fill(.white.opacity(0.1))
                                    
                                    Capsule()
                                        .fill(strength.color)
                                        .frame(width: geo.size.width * strength.widthMultiplier)
                                        .animation(.spring(response: 0.6, dampingFraction: 0.7), value: password)
                                }
                            }
                            .frame(height: 6)
                        }
                        .padding(.horizontal, 10)
                    }
                    .padding()
                }

                Spacer()

                // Final Action
                Button(action: {
                    // Logic to finalize account creation
                }) {
                    Text("Complete Awakening")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.glassProminent)
                .tint(.anikinAccent)
                .disabled(password.count < 6)
                .padding(.horizontal, 40)
                .padding(.bottom, 20)
            }
        }
    }
}
#Preview {
    SecuritySetupView()
}

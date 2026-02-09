//
//  AccountCreationView.swift
//  Anikin
//
//  Created by Abhinav Prasad Yasaswi on 1/21/26.
//

import SwiftUI

struct AccountCreationView: View {
    @State private var username = ""
    @State private var email = ""
    @State private var birthDate = Date()
    @Namespace private var glassNamespace // Enables 2026 morphing effects
    
    // Safety check: User must be 13+
    private var isOldEnough: Bool {
        Calendar.current.date(byAdding: .year, value: -13, to: .now)! >= birthDate
    }

    var body: some View {
        ZStack {
            Color.anikinBase.ignoresSafeArea()
            
            VStack(spacing: 25) {
                // Header
                VStack(alignment: .leading, spacing: 10) {
                    Text("The Final Ritual")
                        .font(.system(size: 34, weight: .black, design: .rounded))
                        .foregroundStyle(.white)
                    Text("Secure your spot in the den.")
                        .foregroundStyle(.white.opacity(0.6))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)

                // 2026 Glass Container
                GlassEffectContainer(spacing: 12) {
                    VStack(spacing: 20) {
                        // Username Field
                        VStack(alignment: .leading) {
                            Label("Chosen Name", systemImage: "leaf.fill")
                                .font(.caption).bold()
                                .foregroundStyle(.anikinAccent)
                            TextField("e.g. SilverPaw", text: $username)
                                .textFieldStyle(.plain)
                        }
                        .padding()
                        .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 20))
                        
                        // Email Field
                        VStack(alignment: .leading) {
                            Label("Email Address", systemImage: "envelope.fill")
                                .font(.caption).bold()
                                .foregroundStyle(.anikinAccent)
                            TextField("nature@den.com", text: $email)
                                .textFieldStyle(.plain)
                                .keyboardType(.emailAddress)
                        }
                        .padding()
                        .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 20))
                        
                        // Birthday Picker
                        HStack {
                            Label("Birth Date", systemImage: "calendar")
                                .font(.caption).bold()
                                .foregroundStyle(.anikinAccent)
                            Spacer()
                            DatePicker("", selection: $birthDate, displayedComponents: .date)
                                .labelsHidden()
                                .tint(.anikinAccent)
                        }
                        .padding()
                        .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 20))
                    }
                    .padding()
                }

                // Error Message
                if !isOldEnough {
                    Text("You must be at least 13 to enter.")
                        .font(.caption)
                        .foregroundStyle(.red.opacity(0.8))
                        .transition(.asymmetric(
                            insertion: .opacity.combined(with: .scale(scale: 0.9)),
                            removal: .opacity
                        ))                }

                Spacer()

                // Glass Prominent Button
                Button(action: {
                    // Final sign-up logic
                }) {
                    Text("Awaken My Profile")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.glassProminent)
                .tint(.anikinAccent)
                .disabled(username.isEmpty || !isOldEnough)
                .padding(.horizontal, 40)
                .padding(.bottom, 20)
            }
        }
    }
}

#Preview {
    AccountCreationView()
}

import SwiftUI
import SwiftData

struct ProfileView: View {
    var onLogout: () -> Void
    @EnvironmentObject var session: SessionStore
    @Query var theriotypes: [Theriotype]
    
    // For the share button animation
    @State private var isSharing = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.anikinBase.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 32) {
                        // 1. The Identity Card (Centerpiece)
                        IdentityCardView(
                            species: theriotypes.first?.species ?? "Grey Wolf",
                            nickname: theriotypes.first?.nickname ?? "Forest Spirit"
                        )
                        .padding(.top, 20)
                        
                        // 2. Profile Actions
                        VStack(spacing: 16) {
                            ActionButton(title: "Share Identity", icon: "square.and.arrow.up", color: .anikinAccent) {
                                // Logic for social share
                            }
                            
                            ActionButton(title: "Privacy Settings", icon: "lock.shield", color: .white.opacity(0.8)) {
                                // Navigate to privacy
                            }
                        }
                        .padding(.horizontal)
                        
                        // 3. Logout (Minimalist Style)
                        Button(action: {
                            session.signOut()
                            onLogout()
                        }) {
                            HStack {
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                Text("Depart the Den (Logout)")
                            }
                            .font(.subheadline.bold())
                            .foregroundStyle(.red.opacity(0.8))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.white.opacity(0.05))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                        .padding(.horizontal)
                        .padding(.top, 40)
                    }
                    .padding(.bottom, 100)
                }
            }
            .navigationTitle("Your Spirit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }
}

// MARK: - The Identity Card Subview
struct IdentityCardView: View {
    let species: String
    let nickname: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("THERIAN IDENTITY")
                        .font(.system(size: 10, weight: .black))
                        .kerning(2)
                        .foregroundStyle(.anikinAccent)
                    
                    Text(nickname)
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                }
                Spacer()
                Image(systemName: "leaf.fill")
                    .font(.title)
                    .foregroundStyle(.anikinAccent)
            }
            
            Divider().background(.white.opacity(0.2))
            
            HStack(spacing: 40) {
                VStack(alignment: .leading) {
                    Text("SPECIES")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(.white.opacity(0.4))
                    Text(species)
                        .font(.callout.bold())
                        .foregroundStyle(.white)
                }
                
                VStack(alignment: .leading) {
                    Text("STATUS")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(.white.opacity(0.4))
                    Text("Awakened")
                        .font(.callout.bold())
                        .foregroundStyle(.anikinForestGlow)
                }
            }
        }
        .padding(30)
        .background {
            ZStack {
                RoundedRectangle(cornerRadius: 32, style: .continuous)
                    .fill(.ultraThinMaterial)
                
                // Aesthetic Background Glow
                Circle()
                    .fill(Color.anikinAccent.opacity(0.2))
                    .blur(radius: 40)
                    .offset(x: 100, y: -50)
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 32, style: .continuous)
                .stroke(LinearGradient(colors: [.white.opacity(0.4), .clear, .white.opacity(0.1)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1.5)
        )
        .padding(.horizontal)
        .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 15)
    }
}

// Simple Helper for Buttons
struct ActionButton: View {
    let title: String
    let icon: String
    let color: Color
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                Text(title)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.caption.bold())
                    .opacity(0.5)
            }
            .font(.headline)
            .foregroundStyle(.white)
            .padding()
            .background(.white.opacity(0.08))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.white.opacity(0.05), lineWidth: 1)
            )
        }
    }
}

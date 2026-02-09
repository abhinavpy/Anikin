import SwiftUI

@main
struct AnikinApp: App {
    @StateObject private var sessionStore = SessionStore()

    init() {
        // Reset UserDefaults for AppStorage keys
        UserDefaults.standard.set(true, forKey: "isOnboarding")
        
        // If your SessionStore uses persistence (like Keychain or UserDefaults),
        // you should call a reset method here or in its own init.
    }

    var body: some Scene {
        WindowGroup {
            Group {
                if !sessionStore.hasCompletedOnboarding {
                    OnboardingView()
                } else if !sessionStore.isLoggedIn {
                    AuthView()
                } else if !sessionStore.hasCreatedAccount {
                    NavigationStack {
                        IdentitySelectionView()
                    }
                } else {
                    ContentView()
                }
            }
            .environmentObject(sessionStore)
            .onAppear {
                // Ensure the sessionStore instance is also reset to defaults
                sessionStore.isLoggedIn = false
                sessionStore.hasCompletedOnboarding = false
                sessionStore.hasCreatedAccount = false
            }
        }
    }
}

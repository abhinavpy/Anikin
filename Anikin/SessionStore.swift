import SwiftUI
import Combine

@MainActor
final class SessionStore: ObservableObject {
    // Persistent state using UserDefaults to ensure values survive app restarts
    @Published var hasCompletedOnboarding: Bool = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
    @Published var isLoggedIn: Bool = UserDefaults.standard.bool(forKey: "isAuthenticated")
    @Published var hasCreatedAccount: Bool = UserDefaults.standard.bool(forKey: "hasCreatedAccount")

    func completeOnboarding() {
        UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
        hasCompletedOnboarding = true
    }

    func loginSuccess() {
        UserDefaults.standard.set(true, forKey: "isAuthenticated")
        isLoggedIn = true
    }

    func completeProfile() {
        UserDefaults.standard.set(true, forKey: "hasCreatedAccount")
        hasCreatedAccount = true
    }

    func signOut() {
        UserDefaults.standard.set(false, forKey: "isAuthenticated")
        isLoggedIn = false
        // Note: We keep hasCompletedOnboarding and hasCreatedAccount as true
        // if you want returning users to skip those steps.
    }
    
    // Inside SessionStore.swift

    func reset() {
        self.isLoggedIn = false
        self.hasCompletedOnboarding = false
        self.hasCreatedAccount = false
        // Clear any other persistent storage (Keychain, etc.) here
    }
}

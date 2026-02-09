import SwiftUI
import AuthenticationServices

struct AuthView: View {
    @EnvironmentObject var session: SessionStore
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color.anikinBase.ignoresSafeArea()
            
            VStack(spacing: 32) {
                Spacer()
                Text("Log in to Join the Den")
                    .font(.system(size: 32, weight: .black, design: .rounded))
                    .foregroundStyle(.white)
                Text("Sign in securely with Apple to continue.")
                    .foregroundStyle(.white.opacity(0.7))
                Spacer()
                
                SignInWithAppleButton(
                    .signIn,
                    onRequest: { request in
                        request.requestedScopes = [.fullName, .email]
                    },
                    onCompletion: handleAuth
                )
                .signInWithAppleButtonStyle(.whiteOutline)
                .frame(height: 54)
                .cornerRadius(14)
                .padding(.horizontal, 40)

                // Debug bypass for Simulator
                #if targetEnvironment(simulator)
                Button(action: {
                    session.loginSuccess()
                }) {
                    Text("Debug: Skip to Login (Simulator Only)")
                        .font(.caption)
                        .foregroundStyle(.anikinAccent)
                }
                .padding(.top, 10)
                #endif
                
                Spacer()
            }
        }
    }
    
    private func handleAuth(_ result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(_):
            session.loginSuccess()
        case .failure(let error):
            print("Apple Sign-In failed: \(error.localizedDescription)")
        }
    }
}

import SwiftUI

struct AccountCreatingView: View {
    let selectedSpecies: Theriotype
    @State private var username: String = ""
    @State private var displayName: String = ""
    @State private var navigateToWelcome = false

    var body: some View {
        ZStack {
            Color.anikinBase.ignoresSafeArea()

            VStack(spacing: 25) {
                VStack(spacing: 10) {
                    Text("Finalize Your Profile")
                        .font(.system(size: 32, weight: .black, design: .rounded))
                        .foregroundStyle(.white)

                    Text("How should the pack address you?")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.7))
                }
                .padding(.top, 40)

                VStack(spacing: 20) {
                    // Username Field
                    VStack(alignment: .leading, spacing: 12) {
                        Text("USERNAME")
                            .font(.caption.bold())
                            .foregroundStyle(.anikinAccent)
                            .padding(.leading, 5)

                        TextField("Choose a unique username", text: $username)
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(15)
                            .foregroundStyle(.white)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                    }

                    // Display Name Field
                    VStack(alignment: .leading, spacing: 12) {
                        Text("DISPLAY NAME")
                            .font(.caption.bold())
                            .foregroundStyle(.anikinAccent)
                            .padding(.leading, 5)

                        TextField("What should we call you?", text: $displayName)
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(15)
                            .foregroundStyle(.white)
                    }
                }
                .padding(.horizontal, 30)

                Spacer()

                Button(action: {
                    if !username.isEmpty && !displayName.isEmpty {
                        navigateToWelcome = true
                    }
                }) {
                    Text("Awaken my profile")
                        .font(.headline)
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(Capsule().fill((username.isEmpty || displayName.isEmpty) ? Color.gray : Color.anikinAccent))
                        .padding(.horizontal, 40)
                        .padding(.bottom, 30)
                }
                .disabled(username.isEmpty || displayName.isEmpty)
            }
        }
        .navigationDestination(isPresented: $navigateToWelcome) {
            FinalWelcomeView(username: username, theriotypeName: selectedSpecies.name)
        }
    }
}

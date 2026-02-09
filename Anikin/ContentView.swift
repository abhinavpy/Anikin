import SwiftUI

struct ContentView: View {
    @State private var selection: MainTab = .home

    var body: some View {
        ZStack {
            // 1. Background
            Color.anikinBase
                .ignoresSafeArea()
            
            // 2. Main content area switches by tab
            Group {
                switch selection {
                case .home:
                    HomeView()
                case .explore:
                    VStack(spacing: 20) {
                        Text("Anikin")
                            .font(.largeTitle.bold())
                            .foregroundColor(.anikinText)
                        
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.anikinSecondary)
                            .frame(height: 100)
                            .overlay(
                                Text("Current Shift: Gray Wolf")
                                    .foregroundColor(.anikinBase)
                                    .bold()
                            )
                            .padding()
                        
                        Button(action: {}) {
                            Text("New Post")
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.anikinAccent)
                                .foregroundColor(.anikinBase)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                    }
                
                case .logger:
                    // Integration of your new ShiftLoggerView
                    ShiftLoggerView()
                case .gear:
                    GearGalleryView()
                case .profile:
                    ProfileView(onLogout: {
                        selection = .home
                    })
                }
            }
            // Ensuring content (especially the ShiftLogger button) doesn't hide behind the bar
            .padding(.bottom, 110)
            
            // 3. The Glass Tab Bar Overlay
            VStack {
                Spacer()
                LiquidGlassTabBar(selection: $selection)
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

import SwiftUI

enum RootTab: Hashable {
    case home, explore, profile
}

struct MainContainerView: View {
    @State private var selection: MainTab = .home

    var body: some View {
        ZStack(alignment: .bottom) {
            // Background color (Using a gradient to show off the glass effect)
            LinearGradient(colors: [Color.blue.opacity(0.5), .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            // Content Screens
            Group {
                switch selection {
                case .home: HomePlaceholder()
                case .explore: ExplorePlaceholder()
                case .profile: ProfilePlaceholder()
                case .logger: LoggerPlaceholder()
                case .gear:
                    GearPlaceholder()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            // The Liquid Tab Bar
            LiquidGlassTabBar(selection: $selection)
        }
    }
}
//struct MainContainerView: View {
//    @State private var selection: RootTab = .home
//
//    var body: some View {
//        ZStack {
//            Color.anikinBase.ignoresSafeArea()
//
//            Group {
//                switch selection {
//                case .home:
//                    HomePlaceholder()
//                case .explore:
//                    ExplorePlaceholder()
//                case .profile:
//                    ProfilePlaceholder()
//                }
//            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
//
//            VStack { Spacer(); LiquidGlassTabBar(selection: $selection) }
//        }
//    }
//}

private struct HomePlaceholder: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("Home")
                .font(.system(size: 32, weight: .black, design: .rounded))
                .foregroundStyle(.white)
            Text("Replace this with your Home screen.")
                .foregroundStyle(.white.opacity(0.7))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

private struct ExplorePlaceholder: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("Explore")
                .font(.system(size: 32, weight: .black, design: .rounded))
                .foregroundStyle(.white)
            Text("Replace this with your Explore screen.")
                .foregroundStyle(.white.opacity(0.7))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

private struct LoggerPlaceholder: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("Explore")
                .font(.system(size: 32, weight: .black, design: .rounded))
                .foregroundStyle(.white)
            Text("Replace this with your Explore screen.")
                .foregroundStyle(.white.opacity(0.7))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

private struct GearPlaceholder: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("Profile")
                .font(.system(size: 32, weight: .black, design: .rounded))
                .foregroundStyle(.white)
            Text("Replace this with your Profile screen.")
                .foregroundStyle(.white.opacity(0.7))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

private struct ProfilePlaceholder: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("Profile")
                .font(.system(size: 32, weight: .black, design: .rounded))
                .foregroundStyle(.white)
            Text("Replace this with your Profile screen.")
                .foregroundStyle(.white.opacity(0.7))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// Dummy LiquidGlassTabBar for independent compilation
struct LiquidGlassTabBar: View {
    @Binding var selection: MainTab
    @Namespace private var animation // For the "liquid" sliding effect

    var body: some View {
        HStack(spacing: 0) {
            ForEach(MainTab.allCases, id: \.self) { tab in
                Button {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                        selection = tab
                    }
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: tab.systemImage)
                            .font(.system(size: 20, weight: .bold))
                        Text(tab.title)
                            .font(.caption2.weight(.medium))
                    }
                    .foregroundColor(selection == tab ? .white : .white.opacity(0.5))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background {
                        if selection == tab {
                            // The "Liquid" pill background
                            RoundedRectangle(cornerRadius: 14, style: .continuous)
                                .fill(.white.opacity(0.15))
                                .matchedGeometryEffect(id: "pill", in: animation)
                        }
                    }
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 8)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(.white.opacity(0.2), lineWidth: 0.5)
        )
        .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
        .padding(.horizontal, 24)
        .padding(.bottom, 20) // Adjust for safe area if not using inside a container that handles it
    }
}
#Preview {
    MainContainerView()
}

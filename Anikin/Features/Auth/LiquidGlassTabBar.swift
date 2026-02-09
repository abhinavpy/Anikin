import SwiftUI

enum MainTab: Hashable, CaseIterable {
    case home, explore, logger, gear, profile

    var title: String {
        switch self {
        case .home: return "Home"
        case .explore: return "Explore"
        case .logger: return "Log"
        case .gear: return "Gear"
        case .profile: return "Profile"
        }
    }

    var systemImage: String {
        switch self {
        case .home: return "house.fill"
        case .explore: return "sparkles"
        case .logger: return "pawprint.fill"
        case .gear: return "wrench.fill"
        case .profile: return "person.crop.circle"
        }
    }
}

struct AuthLiquidGlassTabBar: View {
    @Binding var selection: MainTab
    @Namespace private var animation // For the smooth "liquid" sliding effect

    var body: some View {
        HStack(spacing: 0) { // Spacing 0 because we'll use maxWidth.infinity
            ForEach(MainTab.allCases, id: \.self) { tab in
                Button {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                        selection = tab
                    }
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: tab.systemImage)
                            .font(.system(size: 20, weight: .bold))
                            // Variable color or symbol effect for that 2026 feel
                            .symbolEffect(.bounce, value: selection == tab)
                        
                        Text(tab.title)
                            .font(.caption2.weight(.bold))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .foregroundStyle(selection == tab ? .white : .white.opacity(0.4))
                    .background {
                        // The "Liquid" Selection Pill
                        if selection == tab {
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(.white.opacity(0.1))
                                .matchedGeometryEffect(id: "activeTab", in: animation)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.white.opacity(0.1), lineWidth: 0.5)
                                )
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                        }
                    }
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        // Apply the Liquid Glass Container
        .background {
            ZStack {
                // 1. The Blur
                RoundedRectangle(cornerRadius: 28, style: .continuous)
                    .fill(.ultraThinMaterial)
                
                // 2. The Inner Glow (makes it look "liquid")
                RoundedRectangle(cornerRadius: 28, style: .continuous)
                    .stroke(
                        LinearGradient(
                            colors: [.white.opacity(0.5), .clear, .white.opacity(0.1)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1.2
                    )
            }
        }
        .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
        .padding(.horizontal, 20)
        .padding(.bottom, 8) // Floating off the bottom edge
    }
}

// Helper for binding previews
struct StatefulPreviewWrapper<Value, Content: View>: View {
    @State var value: Value
    var content: (Binding<Value>) -> Content

    init(_ value: Value, content: @escaping (Binding<Value>) -> Content) {
        _value = State(initialValue: value)
        self.content = content
    }

    var body: some View { content($value) }
}

//
//  GearGalleryView.swift
//  Anikin
//
//  Created by Abhinav Prasad Yasaswi on 2/8/26.
//

import SwiftUI
import SwiftData

struct GearGalleryView: View {
    @Query(sort: \GearItem.dateAcquired, order: .reverse) var gear: [GearItem]
    
    // Placeholder data for when the gallery is empty
    let placeholders = [
        GearItem(name: "Forest Wolf Mask", category: "Masks", isFavorite: true),
        GearItem(name: "Midnight Faux Tail", category: "Tails"),
        GearItem(name: "Spirit Claws", category: "Accessories"),
        GearItem(name: "Nature Charm", category: "Jewelry")
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                Color.anikinBase.ignoresSafeArea()
                
                ScrollView {
                    // We use the real gear if it exists, otherwise show placeholders
                    let displayItems = gear.isEmpty ? placeholders : gear
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(displayItems) { item in
                            GearCard(item: item, isPlaceholder: gear.isEmpty)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("The Collection")
        }
    }
}

struct GearCard: View {
    let item: GearItem
    let isPlaceholder: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            // Placeholder Visual
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.ultraThinMaterial)
                    .frame(height: 180)
                
                Image(systemName: getIcon(for: item.category))
                    .font(.system(size: 40))
                    .foregroundStyle(Color.anikinAccent.opacity(isPlaceholder ? 0.4 : 1.0))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.subheadline).bold()
                    .foregroundStyle(.white)
                
                Text(item.category)
                    .font(.caption)
                    .foregroundStyle(.anikinAccent)
            }
            .padding([.horizontal, .bottom], 12)
        }
        .background(.white.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.white.opacity(0.1), lineWidth: 1)
        )
    }
    
    // Helper to pick icons based on category
    func getIcon(for category: String) -> String {
        switch category {
        case "Masks": return "face.dashed"
        case "Tails": return "pawprint.fill"
        case "Accessories": return "hand.raised.fill"
        default: return "sparkles"
        }
    }
}

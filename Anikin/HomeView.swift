//
//  HomeView.swift
//  Anikin
//
//  Created by Abhinav Prasad Yasaswi on 2/9/26.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Query var theriotypes: [Theriotype]
    @Query(sort: \ShiftLog.timestamp, order: .reverse) var logs: [ShiftLog]
    
    // Placeholder Data for a "First Time" or "Development" view
    let placeholderNickname = "Forest Wanderer"
    let placeholderSpecies = "Grey Wolf"
    let placeholderLogCount = "12"
    let placeholderGearCount = "4"

    var body: some View {
        NavigationStack {
            ZStack {
                Color.anikinBase.ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        
                        // 1. Header with Placeholder Logic
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Welcome Home,")
                                    .font(.subheadline)
                                    .foregroundStyle(.anikinSecondary)
                                
                                // Uses real name if available, otherwise placeholder
                                Text(theriotypes.first?.nickname ?? placeholderNickname)
                                    .font(.system(size: 32, weight: .black, design: .rounded))
                                    .foregroundStyle(.white)
                            }
                            Spacer()
                            
                            Image(systemName: "pawprint.circle.fill")
                                .font(.system(size: 44))
                                .foregroundStyle(.anikinAccent)
                                .symbolEffect(.pulse)
                        }
                        .padding(.horizontal)
                        
                        // 2. The Daily Instinct Card
                        DailyInstinctCard()
                            .padding(.horizontal)
                        
                        // 3. Quick Stats with Placeholder Logic
                        HStack(spacing: 16) {
                            StatCard(
                                title: "Total Shifts",
                                value: logs.isEmpty ? placeholderLogCount : "\(logs.count)",
                                icon: "leaf.arrow.triangle.circlepath"
                            )
                            StatCard(
                                title: "Gear Count",
                                value: placeholderGearCount,
                                icon: "archivebox.fill"
                            )
                        }
                        .padding(.horizontal)
                        
                        // 4. Last Recorded Shift (Showing a "Sample" if logs are empty)
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Recent Connection")
                                .font(.headline)
                                .foregroundStyle(.white.opacity(0.8))
                            
                            if let lastLog = logs.first {
                                RecentShiftCard(log: lastLog)
                            } else {
                                // Sample Card for Preview
                                SampleShiftCard(type: "Phantom Shift", date: "Just now")
                            }
                        }
                        .padding(.horizontal)
                        
                        Spacer(minLength: 100)
                    }
                    .padding(.top, 20)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

// A static version of the shift card for when no data exists
struct SampleShiftCard: View {
    let type: String
    let date: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(type)
                    .font(.subheadline.bold())
                    .foregroundStyle(.white)
                Text(date)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.5))
            }
            Spacer()
            Text("Sample")
                .font(.caption2).bold()
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(.white.opacity(0.1))
                .clipShape(Capsule())
                .foregroundStyle(.anikinSecondary)
        }
        .padding()
        .background(.white.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

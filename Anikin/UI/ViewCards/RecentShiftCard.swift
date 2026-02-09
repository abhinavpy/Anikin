//
//  RecentShiftCard.swift
//  Anikin
//
//  Created by Abhinav Prasad Yasaswi on 2/9/26.
//

import SwiftUI
struct RecentShiftCard: View {
    let log: ShiftLog
    
    var body: some View {
        HStack(spacing: 16) {
            // Icon Background
            ZStack {
                Circle()
                    .fill(Color.anikinAccent.opacity(0.15))
                    .frame(width: 48, height: 48)
                
                Image(systemName: "leaf.fill")
                    .foregroundStyle(.anikinAccent)
                    .font(.system(size: 20))
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(log.type)
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(.white)
                
                Text(log.timestamp.formatted(date: .abbreviated, time: .shortened))
                    .font(.system(size: 13))
                    .foregroundStyle(.white.opacity(0.5))
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(.white.opacity(0.3))
        }
        .padding(16)
        .background(.white.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .stroke(Color.white.opacity(0.05), lineWidth: 1)
        )
    }
}

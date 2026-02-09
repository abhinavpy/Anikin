//
//  ShiftLoggerView.swift
//  Anikin
//
//  Created by Abhinav Prasad Yasaswi on 2/8/26.
//

import SwiftUI
import Combine
import SwiftData

struct ShiftLoggerView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var isRecording = false
    @State private var duration: TimeInterval = 0
    @State private var startTime: Date?
    @State private var selectedType: ShiftType = .mental
    @State private var notes: String = ""
    @State private var intensity: Double = 3.0 // Added for more data depth

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    enum ShiftType: String, CaseIterable, Identifiable {
        case mental = "Mental", phantom = "Phantom", sensory = "Sensory", dream = "Dream"
        var id: String { rawValue }
        
        var icon: String {
            switch self {
            case .mental: return "brain"
            case .phantom: return "waveform.path"
            case .sensory: return "eye.fill"
            case .dream: return "moon.stars.fill"
            }
        }
    }

    var body: some View {
        ZStack {
            // 1. Immersive Background
            ZStack {
                Color.anikinBase.ignoresSafeArea()
                
                // Animated glow that appears only when recording
                Circle()
                    .fill(isRecording ? Color.anikinAccent.opacity(0.15) : Color.clear)
                    .blur(radius: 80)
                    .scaleEffect(isRecording ? 1.5 : 0.5)
                    .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: isRecording)
            }
            .ignoresSafeArea()

            VStack(spacing: 20) {
                // Header with subtle vibe
                VStack(spacing: 4) {
                    Text("Shift Journal")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                    
                    Text(isRecording ? "Connection Active" : "Prepare for Connection")
                        .font(.caption)
                        .foregroundStyle(isRecording ? .anikinForestGlow : .white.opacity(0.4))
                        .kerning(1)
                }
                .padding(.top, 20)

                // 2. Liquid Glass Timer
                VStack(spacing: 10) {
                    Text(formattedDuration)
                        .font(.system(size: 64, weight: .thin, design: .monospaced))
                        .foregroundStyle(.white)
                        .contentTransition(.numericText()) // Smoothly animates numbers
                    
                    if isRecording {
                        HStack {
                            Circle().fill(.red).frame(width: 8, height: 8)
                            Text("RECORDING").font(.system(size: 10, weight: .black)).kerning(2)
                        }
                        .foregroundStyle(.white.opacity(0.6))
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 40)
                .background(.ultraThinMaterial.opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .overlay(RoundedRectangle(cornerRadius: 40).stroke(.white.opacity(0.1), lineWidth: 1))
                .padding(.horizontal)

                // 3. Selection & Notes
                VStack(spacing: 20) {
                    if !isRecording {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(ShiftType.allCases) { type in
                                    ShiftTypeButton(type: type, selected: $selectedType)
                                }
                            }
                            .padding(.horizontal)
                        }
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                    }

                    // Journal Notes Card
                    VStack(alignment: .leading, spacing: 12) {
                        Label("NOTES", systemImage: "pencil.line")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundStyle(.anikinAccent)
                        
                        TextField("Describe the sensations...", text: $notes, axis: .vertical)
                            .lineLimit(3...5)
                            .foregroundStyle(.white)
                    }
                    .padding(20)
                    .background(.white.opacity(0.05))
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .padding(.horizontal)
                }

                Spacer()

                // 4. The "Liquid" Button
                Button {
                    toggleShift()
                } label: {
                    ZStack {
                        // The Outer Ring (Pulse effect)
                        Circle()
                            .stroke(isRecording ? Color.red.opacity(0.3) : Color.anikinAccent.opacity(0.3), lineWidth: 4)
                            .scaleEffect(isRecording ? 1.2 : 1.0)
                            .opacity(isRecording ? 0 : 1)
                            .animation(isRecording ? .easeOut(duration: 1.5).repeatForever(autoreverses: false) : .default, value: isRecording)

                        Circle()
                            .fill(.ultraThinMaterial)
                            .overlay(
                                Circle()
                                    .stroke(isRecording ? Color.red : Color.anikinAccent, lineWidth: 2)
                            )
                        
                        Image(systemName: isRecording ? "stop.fill" : "pawprint.fill")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundStyle(isRecording ? .red : .anikinAccent)
                    }
                    .frame(width: 90, height: 90)
                }
                .buttonStyle(GrowingButton())
            }
            .padding(.bottom, 100)
        }
        .onReceive(timer) { _ in
            if isRecording, let start = startTime {
                duration = Date().timeIntervalSince(start)
            }
        }
    }

    // MARK: - Logic Helpers
    private var formattedDuration: String {
        let minutes = Int(duration) / 60 % 60
        let seconds = Int(duration) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    private func toggleShift() {
        let impact = UIImpactFeedbackGenerator(style: .medium)
        impact.impactOccurred()
        
        withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
            if isRecording {
                stopRecording()
            } else {
                startRecording()
            }
        }
    }

    private func startRecording() {
        startTime = Date()
        isRecording = true
    }

    private func stopRecording() {
        // SAVE TO SWIFTDATA
        let newLog = ShiftLog(
            timestamp: Date(),
            type: selectedType.rawValue,
            intensity: Int(intensity),
            note: notes
        )
        modelContext.insert(newLog)
        
        isRecording = false
        duration = 0
        notes = ""
    }
}

struct ShiftTypeButton: View {
    let type: ShiftLoggerView.ShiftType
    @Binding var selected: ShiftLoggerView.ShiftType

    var body: some View {
        Button {
            selected = type
        } label: {
            HStack(spacing: 8) {
                Image(systemName: type.icon)
                Text(type.rawValue)
            }
            .font(.system(size: 14, weight: .bold))
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(selected == type ? Color.anikinAccent : .white.opacity(0.05))
            .foregroundStyle(selected == type ? Color.anikinBase : .white)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(.white.opacity(0.1), lineWidth: 1))
        }
        .buttonStyle(.plain)
    }
}

struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

#Preview {
    ShiftLoggerView()
}

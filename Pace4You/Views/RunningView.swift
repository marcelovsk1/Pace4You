//
//  RunningView.swift
//  Pace4You
//
//  Created by Marcelo Amaral Alves on 2024-06-16.
//

import SwiftUI
import MapKit

struct RunningView: View {
    @StateObject private var locationService = LocationService()
    @State private var distance: Double = 0.0
    @State private var duration: TimeInterval = 0.0
    @State private var pace: Double = 0.0
    @State private var timer: Timer?
    @State private var isPaused: Bool = false

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.6)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)

            VStack {
                UserTrackingMapView(region: $locationService.region)
                    .frame(height: 300)
                    .cornerRadius(20)
                    .padding()

                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "map.fill")
                                .foregroundColor(.white)
                            Text("Distance: \(String(format: "%.2f", distance)) km")
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                        HStack {
                            Image(systemName: "clock.fill")
                                .foregroundColor(.white)
                            Text("Time: \(formattedTime(duration))")
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                        HStack {
                            Image(systemName: "speedometer")
                                .foregroundColor(.white)
                            Text("Pace: \(String(format: "%.2f", pace)) min/km")
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                    }
                    Spacer()
                    // Avatar Placeholder
                    Image(systemName: "figure.walk.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.black.opacity(0.4))
                .cornerRadius(20)
                .padding([.leading, .trailing])

                Spacer()

                Button(action: {
                    isPaused.toggle()
                    if isPaused {
                        stopRun()
                    } else {
                        resumeRun()
                    }
                }) {
                    Text(isPaused ? "Resume" : "Pause")
                        .font(.title2)
                        .fontWeight(.bold)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(isPaused ? Color.green : Color.red)
                        .cornerRadius(50)
                        .padding(.horizontal)
                        .shadow(radius: 10)
                }
            }
            .padding(.top)
        }
        .onAppear(perform: startRun)
    }

    func startRun() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            duration += 1.0
            updatePace()
        }
    }

    func stopRun() {
        timer?.invalidate()
        timer = nil
    }

    func resumeRun() {
        startRun()
    }

    func updatePace() {
        // Calculate pace based on duration and distance
        if distance > 0 {
            pace = duration / 60.0 / distance
        }
    }

    func formattedTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    RunningView()
}

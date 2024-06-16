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
    @State private var temperature: String = "--"

    var body: some View {
        ZStack {
            // Background Map
            UserTrackingMapView(region: $locationService.region)
                .edgesIgnoringSafeArea(.all)
            
            // Overlay Content
            VStack {
                Spacer()
                
                if isPaused {
                    pausedView
                        .transition(.move(edge: .bottom))
                } else {
                    runningView
                        .transition(.move(edge: .bottom))
                }
            }
        }
        .animation(.easeInOut, value: isPaused)
        .onAppear(perform: startRun)
    }
    
    var pausedView: some View {
        VStack(spacing: 20) {
            Text("Run Paused")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            HStack {
                Image(systemName: "clock.fill")
                    .foregroundColor(.white)
                Text("Time: \(formattedTime(duration))")
                    .foregroundColor(.white)
                    .font(.headline)
            }
            HStack {
                Image(systemName: "map.fill")
                    .foregroundColor(.white)
                Text("Distance: \(String(format: "%.2f", distance)) km")
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
            HStack {
                Image(systemName: "thermometer")
                    .foregroundColor(.white)
                Text("Temperature: \(temperature)°C")
                    .foregroundColor(.white)
                    .font(.headline)
            }
            
            Button(action: {
                isPaused = false
                resumeRun()
            }) {
                Text("RESUME")
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .shadow(radius: 10)
            }
        }
        .padding()
        .background(Color.black.opacity(0.7))
        .cornerRadius(20)
        .padding()
    }
    
    var runningView: some View {
        VStack {
            Spacer()
            
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
            
            Button(action: {
                isPaused = true
                stopRun()
                fetchTemperature()
            }) {
                Text("STOP")
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .shadow(radius: 10)
            }
            .padding(.bottom, 50)
        }
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
    
    func fetchTemperature() {
        // Simulate fetching temperature for the current location
        // In a real app, you would use an API to get the temperature
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.temperature = "25" // Example temperature
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

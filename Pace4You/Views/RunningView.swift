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
        VStack {
            UserTrackingMapView(region: $locationService.region)
                .frame(height: 300)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Distance: \(String(format: "%.2f", distance)) km")
                    Text("Time: \(formattedTime(duration))")
                    Text("Pace: \(String(format: "%.2f", pace)) min/km")
                }
                Spacer()
                // Avatar Placeholder
                Image(systemName: "figure.walk.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
            }
            .padding()
            
            Spacer()
            
            Button(action: {
                isPaused.toggle()
                if isPaused {
                    stopRun()
                } else {
                    resumeRun()
                }
            }) {
                Text(isPaused ? "RESUME" : "STOP")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(isPaused ? Color.green : Color.red)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
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

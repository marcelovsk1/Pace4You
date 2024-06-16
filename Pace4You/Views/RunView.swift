//
//  RunView.swift
//  Pace4You
//
//  Created by Marcelo Amaral Alves on 2024-06-16.
//

import SwiftUI
import MapKit

struct RunView: View {
    @StateObject private var locationService = LocationService()
    @State private var isRunning = false
    
    var body: some View {
        NavigationView {
            VStack {
                UserTrackingMapView(region: $locationService.region)
                    .frame(height: 300)
                
                Button(action: {
                    isRunning = true
                }) {
                    Text("START")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                
                Spacer()
            }
            .background(
                NavigationLink(destination: RunningView(), isActive: $isRunning) {
                    EmptyView()
                }
            )
        }
    }
}

#Preview {
    RunView()
}

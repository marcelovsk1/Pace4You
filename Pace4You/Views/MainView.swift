//
//  View_1.swift
//  Pace4You
//
//  Created by Marcelo Amaral Alves on 2024-06-14.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            RunView()
                .tabItem {
                    Image(systemName: "figure.walk")
                    Text("Run")
                }
            
            MapView()
                .tabItem {
                    Image(systemName: "map")
                    Text("Map")
                }
            
            SocialView()
                .tabItem {
                    Image(systemName: "person.2")
                    Text("Social")
                }
            
            TrainingView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Training")
                }
        }
    }
}

struct RunView: View {
    @StateObject private var viewModel = RunViewModel()
    
    var body: some View {
        VStack {
            // Run tracking interface
            Text("Run Tracking")
            Button("Start Run") {
                viewModel.startRun()
            }
            Button("End Run") {
                viewModel.endRun()
            }
        }
    }
}

struct MapView: View {
    @StateObject private var locationService = LocationService()
    
    var body: some View {
        VStack {
            Text("Map and Routes")
            // Map interface
        }
    }
}

struct SocialView: View {
    var body: some View {
        VStack {
            Text("Social Feed")
            // Social interface
        }
    }
}

struct TrainingView: View {
    var body: some View {
        VStack {
            Text("Training Plans")
            // Training interface
        }
    }
}

#Preview {
    MainView()
}

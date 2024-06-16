import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
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
}

struct MapView: View {
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

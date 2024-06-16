//
//  UserTrackingMapView.swift
//  Pace4You
//
//  Created by Marcelo Amaral Alves on 2024-06-16.
//

import SwiftUI
import MapKit

struct UserTrackingMapView: View {
    @Binding var region: MKCoordinateRegion

    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true)
            .edgesIgnoringSafeArea(.top)
            .frame(height: 300)
            .onAppear {
                setRegionToUserLocation()
            }
    }
    
    private func setRegionToUserLocation() {
        // Set initial region to user location (this could be refined with CLLocationManager if needed)
        region = MKCoordinateRegion(
            center: CLLocationManager().location?.coordinate ?? CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    }
}

#Preview {
    UserTrackingMapView(region: .constant(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )))
}

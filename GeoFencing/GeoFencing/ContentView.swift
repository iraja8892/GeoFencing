//
//  ContentView.swift
//  GeoFencing
//
//  Created by Raja Inbam on 2024-07-17.
//

import SwiftUI
import CoreLocation

// Samples Geofences Points
let rawRegions = [
    ("Cupertino",37.334606, -122.009102),
    ("Apple",43.217777, -79.987282)
]

// Transforming simple regions into [CLCircularRegion]
let regions = rawRegions.map({ (identifier, lat, lon) in
                CLCircularRegion(center: CLLocationCoordinate2DMake(lat, lon),
                                 radius: 80,
                                 identifier: identifier)})

struct ContentView: View {
    @EnvironmentObject var geofenceState: GeofenceState
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button {
                if geofenceState.isGeofencingRunning{
                    geofenceState.stopGeofencing()
                } else {
                    geofenceState.startGeofencing(regionsToMonitor: regions)
                }
            } label: {
                Text(geofenceState.isGeofencingRunning ? "Stop Monitor Regions" : "Start Monitor Regions")
            }
        }
        .padding()
        .onAppear {
            geofenceState.loadPermissions()
            geofenceState.askForAllPermissions()
        }
    }
}

#Preview {
    ContentView()
}

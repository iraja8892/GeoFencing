//
//  GeoFencingApp.swift
//  GeoFencing
//
//  Created by Raja Inbam on 2024-07-17.
//

import SwiftUI

@main
struct GeoFencingApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(GeofenceState())
        }
    }
}

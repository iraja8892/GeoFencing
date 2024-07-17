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

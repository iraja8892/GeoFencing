import SwiftUI
import FirebaseCore
import CoreLocation

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct GeoFencingApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var remoteConfig: RemoteConfig = RemoteConfig()
    @StateObject var geofenceState = GeofenceState()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(geofenceState)
                .environmentObject(remoteConfig)
                .onAppear() {
                    remoteConfig.fetchRemoteConfig()
                }
                .onChange(of: remoteConfig.locations) {
                    let regions = remoteConfig.locations.map {
                        CLCircularRegion(center: CLLocationCoordinate2DMake($0.lat, $0.lon),
                                         radius: 80,
                                         identifier: $0.name)
                    }
                    geofenceState.startGeofencing(regionsToMonitor: regions)
                }
        }
    }
}

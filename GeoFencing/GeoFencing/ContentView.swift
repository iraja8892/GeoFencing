import SwiftUI
import CoreLocation
import MapKit


struct ContentView: View {
    @AppStorage("User") private var user = ""
    @EnvironmentObject var geofenceState: GeofenceState
    @EnvironmentObject var remoteConfig: RemoteConfig
    @StateObject var analytics =  Analytics()
    @State var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.785834, longitude: -122.406417), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    var body: some View {
        VStack {
            if user.isEmpty {
                Text("Welome to the demo app")
            } else {
                Text("Welcome back \($user.wrappedValue)")
            }
            VStack(alignment: .leading, spacing: 8) {
                TextField("Enter your name", text: $user)
                Button("Remember") {
                    analytics.userId($user.wrappedValue)
                }
            }
            .padding(.all)
            .cornerRadius(2)
            .overlay( /// apply a rounded border
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.black, lineWidth: 1)
            )
            Map() {
                ForEach(remoteConfig.locations) { location in
                    Marker(location.name, coordinate: CLLocationCoordinate2D(latitude: location.lat, longitude: location.lon))
                }
                if let coordinate = geofenceState.coordinate {
                    Marker("You", systemImage: "person", coordinate: coordinate)
                        .tint(.yellow)
                }
                
            }
        }
        .onAppear {
            geofenceState.loadPermissions()
            geofenceState.askForAllPermissions()
        }
    }
}

#Preview {
    ContentView()
}

import SwiftUI
import CoreLocation
import MapKit


struct ContentView: View {
    @AppStorage("User") private var user = ""
    @AppStorage("firstTime") private var firstTime: Bool = true
    @EnvironmentObject var geofenceState: GeofenceState
    @EnvironmentObject var remoteConfig: RemoteConfig
    @StateObject var analytics =  Analytics()
    @State var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.785834, longitude: -122.406417), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    var body: some View {
        VStack {
            if firstTime {
                Text("Welome to the demo app")
                Spacer()
                VStack(alignment: .leading, spacing: 8) {
                    TextField("Enter your name", text: $user)
                    Button("Remember") {
                        analytics.userId(user)
                        firstTime.toggle()
                    }
                }
                .padding(.all)
                .cornerRadius(2)
                .overlay( /// apply a rounded border
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.black, lineWidth: 1)
                )
                Spacer()
            } else {
                Text("Welcome \(user) to the demo app")
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

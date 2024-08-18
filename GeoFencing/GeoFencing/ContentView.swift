import SwiftUI
import CoreLocation

//// Samples Geofences Points
//let rawRegions = [
//    ("Cupertino",37.334606, -122.009102),
//    ("Apple",43.217777, -79.987282)
//]
//
//// Transforming simple regions into [CLCircularRegion]
//let regions = rawRegions.map({ (identifier, lat, lon) in
//                CLCircularRegion(center: CLLocationCoordinate2DMake(lat, lon),
//                                 radius: 80,
//                                 identifier: identifier)})

struct ContentView: View {
    @AppStorage("User") private var user = ""
    @EnvironmentObject var geofenceState: GeofenceState
    @EnvironmentObject var remoteConfig: RemoteConfig
    @StateObject var analytics =  Analytics()
    var body: some View {
        VStack {
            if user.isEmpty {
                Text("Welome to the demo app")
            } else {
                Text("Welcome back \($user.wrappedValue)")
            }
            Spacer()
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
            Spacer()
        }
        .padding()
        .background(.white)
        .onAppear {
            geofenceState.loadPermissions()
            geofenceState.askForAllPermissions()
        }
    }
}

#Preview {
    ContentView()
}

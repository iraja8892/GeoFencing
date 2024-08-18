//
//  RemoteConfig.swift
//  GeoFencing
//
//  Created by anand sankaran on 8/18/24.
//

import Foundation
import FirebaseRemoteConfig

class RemoteConfig: ObservableObject {
    
    @Published var locations: [Location] = []
    func fetchRemoteConfig() {
        let remoteConfig =  FirebaseRemoteConfig.RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0 // Fetch immediately
        remoteConfig.configSettings = settings
        remoteConfig.fetchAndActivate { (status, error) in
            
            if status == .successFetchedFromRemote {
                print("Remote config fetched and activated successfully.")
                // Access the fetched values
                let data = remoteConfig["locations"].dataValue
                
                let decoder = JSONDecoder()
                
                if let locations = try? decoder.decode([Location].self, from: data) {
                    self.locations = locations
                    print(locations)
                }
                // ...
            } else if let error = error {
                print("Error fetching remote config: \(error)")
            }
        }
    }
}

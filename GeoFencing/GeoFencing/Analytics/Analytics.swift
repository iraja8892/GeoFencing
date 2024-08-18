//
//  Analytics.swift
//  GeoFencing
//
//  Created by anand sankaran on 8/18/24.
//

import Foundation
import FirebaseAnalytics

class Analytics: ObservableObject {
    
    func userId(_ id:String?) {
        FirebaseAnalytics.Analytics.setUserID(id)
    }
    
    func context(key: String, value: String?) {
        FirebaseAnalytics.Analytics.setUserProperty(value, forName: key)

    }
    
    func logEvent(event: String, param: [String: Any]? = nil) {
        FirebaseAnalytics.Analytics.logEvent(event, parameters: param)
    }
}

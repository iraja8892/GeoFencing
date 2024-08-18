//
//  Location.swift
//  GeoFencing
//
//  Created by anand sankaran on 8/18/24.
//

import Foundation

struct Location: Equatable {
    let name: String
    let address: String
    let lat: Double
    let lon: Double
}

extension Location: Decodable {

}

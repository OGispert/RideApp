//
//  DistanceManager.swift
//  RideApp
//
//  Created by Othmar Gispert on 9/23/22.
//

import Foundation
import CoreLocation

class DistanceManager: NSObject, ObservableObject {
    @Published var distance: Double? = 0

    func distance(locations: [CLLocation]) {
        if let locationA = locations.first, let locationB = locations.last {
            distance = Double(locationA.distance(from: locationB) / 1000)
        }
    }
}

extension CLLocation {
    var latitude: Double {
        return self.coordinate.latitude
    }

    var longitude: Double {
        return self.coordinate.longitude
    }
}

//
//  SettingsManager.swift
//  RideApp
//
//  Created by ogisq on 9/23/22.
//

import Foundation
import Combine

class SettingsManager: ObservableObject {

    let objectWillChange = PassthroughSubject<Void, Never>()

    @SettingsDefault(key: "travelRadius", value: 300)
    
    var travelRadius: Double {
        willSet {
            objectWillChange.send()
        }
    }
}

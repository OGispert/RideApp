//
//  SettingsDefault.swift
//  RideApp
//
//  Created by Othmar Gispert on 9/23/22.
//

import Foundation

@propertyWrapper
struct SettingsDefault<T> {
    let key: String
    let value: T

    init(key: String, value: T) {
        self.key = key
        self.value = value
    }

    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? value
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

//
//  UserSettingsDefaults.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 14.05.2024.
//

import Foundation

struct UserSettingsDefaults {
    
    let defaults = UserDefaults.standard
    
    enum Settings {
        case LAST_ACCESS_APP_OPPENED(datetime: Double = 0)
    }
    
    func saveAccessTime(now: Double) async {
//        defaults.removeObject(forKey: "LastAccessTime")
        defaults.set(now, forKey: "LastAccessTime")
    }
    
    func getAccessTime() async -> Double {
        return defaults.double(forKey: "LastAccessTime")
    }
}

//
//  GetUserSettings.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 14.05.2024.
//

import Foundation

class GetUserSettingsUseCase: NSObject {
    
    private var settings: UserSettingsDefaults? = nil
    
    init(settings: UserSettingsDefaults?) {
        self.settings = settings
    }
    
    func saveAccessTime(now: Double) async -> Void {
        await settings?.saveAccessTime(now: now)
    }
    
    func getAccessTime() async -> Double {
        return await settings?.getAccessTime() ?? 0
    }
}

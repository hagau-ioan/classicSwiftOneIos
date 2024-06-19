//
//  PermissionsHandler.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 05.06.2024.
//

import Foundation

import UserNotifications

class PermissionsHandler: NSObject {
    
    static let shared = PermissionsHandler()
    
    private override init() {}
    
    func isNotificationPermissionAllowed(onResult: @escaping (Bool) -> Void = {_ in}) {
        let current = UNUserNotificationCenter.current()
        current.getNotificationSettings(completionHandler: { permission in
            var allowed = false
            switch permission.authorizationStatus  {
            case .authorized:
                allowed = true
            case .denied:
                allowed = false
            case .notDetermined:
                allowed = false
            case .provisional:
                // @available(iOS 12.0, *)
                allowed = true
            case .ephemeral:
                // @available(iOS 14.0, *)
                allowed = true
            @unknown default:
                allowed = false
            }
            onResult(allowed)
        })
    }
    
    func requestNotificationPermission(onSuccess: @escaping () -> Void = {}, onError: @escaping () -> Void = {}) {
        isNotificationPermissionAllowed(onResult: { allowed in
            print("notifications are allowed: \(allowed)")
            if !allowed {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                    print("test 1 \(granted)")
                    if granted {
                        print("test 2")
                        onSuccess()
                    } else {
                        onError()
                    }
                }
            } else {
                onSuccess()
            }
        })
    }
    
}

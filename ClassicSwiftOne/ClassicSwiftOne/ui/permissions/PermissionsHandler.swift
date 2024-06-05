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
            print("allowed: \(allowed)")
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
    
    func scheduleNotificationDemo() {
        let center = UNUserNotificationCenter.current()
        
        // Cleanup all notifications from the center to test faster the notification
        center.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "A notification title"
        content.body = "A notification message related to this notification title as POC."
        content.categoryIdentifier = "alarm" // alert , background , voip , complication , fileprovider , or mdm
        content.userInfo = ["customData": "some info here"]
        content.sound = UNNotificationSound.default
        
        //        var dateComponents = DateComponents() // create a repeating alarm at 10:30am every morning
        //        dateComponents.hour = 10
        //        dateComponents.minute = 30
        //        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // use this identifier to cancel the request if it’s still pending
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        center.add(request) { (error) in
            if let error = error {
                print("Error adding notification request: \(error)")
            }
        }
        
    }
    
}

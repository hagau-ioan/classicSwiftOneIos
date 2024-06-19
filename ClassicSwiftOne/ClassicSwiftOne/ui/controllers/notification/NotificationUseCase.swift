//
//  NotificationStandard.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 18.06.2024.
//

import Foundation
import UserNotifications

class NotificationUseCase: NSObject {
    
    static let shared = NotificationUseCase()
    
    private override init() {}
    
    /*
     * A standard notification display
     */
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
    
    /*
     * Similar to a standard notification but with a sensitive setting:
     * content.interruptionLevel = .timeSensitive
     */
    func scheduleNotificationSensitive() {
        
        //Notification for start time Content
        let content = UNMutableNotificationContent()
        content.title = "Sensitive Notification Title "
        content.body = "A sensitive notification message related to this notification title as POC."
        content.interruptionLevel = .timeSensitive // TIME SENSITIVE SETTING
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents() // create a repeating alarm at 10:30am every morning
        dateComponents.hour = 10
        dateComponents.minute = 30
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        
        let center = UNUserNotificationCenter.current()
        // use this identifier to cancel the request if it’s still pending
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        center.add(request) { (error) in
            if let error = error {
                print("Error adding notification request: \(error)")
            }
        }
    }
}

//
//  AppDelegate.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 15.04.2024.
//

import UIKit
import BackgroundTasks

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    /*
     * BGAppRefreshTask and BGProcessingTask require to be run on the device.
     */
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        /*
         * BGAppRefreshTask is for short-duration tasks that expect quick results, such as downloading a stock quote. BGProcessingTask is for tasks that might be time-consuming, such as downloading a large file or synchronizing data.
         Need to be configured in the plist too.
         */
        let bgServiceMgm: BackgroundServiceManagement = BackgroundServiceManagement.shared
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.classicswiftone.bgprocessing", using: DispatchQueue.main) { task in
            bgServiceMgm.handleAppProcessingRefresh(task: task as! BGProcessingTask)
        }
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.classicswiftone.bgrefreshing", using: DispatchQueue.main) { task in
            bgServiceMgm.handleAppRefresh(task: task as! BGAppRefreshTask)
        }
        
        // Preparation to check the permission and also to do the setup for sending notification NOW (not scheduled for other time).
        UNUserNotificationCenter.current().delegate = self
        PermissionsHandler.shared.requestNotificationPermission() {
            // Trigger a notification banner as DEMO test after permissions are allowed
            PermissionsHandler.shared.scheduleNotificationDemo()
        } onError: {
            print("Notification permission is forbidden")
        }

        return true
    }
    
    // UNUserNotificationCenterDelegate - method to trigger a notification display NOW
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent: UNNotification,
                                withCompletionHandler: @escaping (UNNotificationPresentationOptions)->()) {
        // .list - must match the type of "notification banner|list type display" setup in the Settings for the app notification.
        withCompletionHandler([.banner, .list, .sound, .badge])
    }
    
    // UNUserNotificationCenterDelegate - method to trigger a notification display NOW
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive: UNNotificationResponse,
                                withCompletionHandler: @escaping ()->()) {
        withCompletionHandler()
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func application(
        _ application: UIApplication,
        didReceiveRemoteNotification userInfo: [AnyHashable : Any],
        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
            // Handle the remote notification
            // your app has up to 30 seconds to complete its work. One your app performs the work, call the passed completion handler as soon as possible to conserve power. If you send background pushes more frequently than three times per hour, the system imposes rate limitations
        }
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // Handle regular time dealy background tasks: <key>UIBackgroundFetchIntervalMinimum</key> need to be specified.
    }
}



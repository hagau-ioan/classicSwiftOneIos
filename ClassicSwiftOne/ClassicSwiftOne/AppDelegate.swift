//
//  AppDelegate.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 15.04.2024.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    
    /*
     * BGAppRefreshTask and BGProcessingTask require to be run on the device.
     */
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        let sceneConfig : UISceneConfiguration = UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self
        return sceneConfig
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



//
//  BackgroundServiceManagement.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 21.05.2024.
//

import Foundation
import BackgroundTasks

/*
 * Run of these will be decided by the system based on the user behaviour.
 * plist configuration will be required to register the identifiers
 *
 * HOW TO test quick this:
 * 1. Put the app in the background
 * 2. Pause the app from Bottom console and add into the console:
 *      e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateLaunchForTaskWithIdentifier:@"com.classicswiftone.bgrefreshing"]
 * 3. Bring the app in foreground and press play from bottom console
 * 4. The example need to be run on real device, on emulator is not working.
 * Reference: https://developer.apple.com/videos/play/wwdc2019/707
 */
final class BackgroundServiceManagement: NSObject {
    
    static let shared = BackgroundServiceManagement()
    
    private let identifierRefreshID = "com.classicswiftone.bgrefreshing"
    private let identifierProcessID = "com.classicswiftone.bgprocessing"
    
    private override init() {
        
    }
    /*
     * ********* The solution is to run on a device.**********
     */
    func didEnteredBackground() {
        scheduleAppRefresh()
        scheduleAppProcessingRefresh()
    }
    /*
     * Maximum 30 seconds duration
     */
    func handleAppRefresh(task: BGAppRefreshTask) {
        let bgService = BackgroundShortService()
        scheduleAppRefresh()
        let bgTask = bgService.start(task: task)
        // Provide the background task with an expiration handler that cancels the operation.
        task.expirationHandler = {
            bgService.stop()
            bgTask.cancel()
        }
        print("BG Background Task fired")
    }
    
    /*
     * Schedule a very short task will run for 15 seconds (allowed by the system)
     * Can create multiple instances based on the job need to be done
     */
    func scheduleAppRefresh() {
        let request = BGAppRefreshTaskRequest(identifier: identifierRefreshID)
        request.earliestBeginDate = Date(timeIntervalSinceNow: 3 * 60)
        do {
            try BGTaskScheduler.shared.submit(request)
            print("scheduleAppRefresh Scheduled")
        } catch {
            print("Could not schedule app refresh: \(error)")
        }
    }
    
    func handleAppProcessingRefresh(task: BGProcessingTask) {
        let bgService = BackgroundLongService()
        scheduleAppProcessingRefresh()
        let bgTask = bgService.start(task: task)
        // Provide the background task with an expiration handler that cancels the operation.
        task.expirationHandler = {
            bgService.stop()
            bgTask.cancel()
        }
        print("BG processing Background Task fired")
    }
    
    /*
     * Can create multiple instances based on the job need to be done
     */
    func scheduleAppProcessingRefresh() {
        let request = BGProcessingTaskRequest(identifier: identifierProcessID)
        request.requiresNetworkConnectivity = true
        // request.earliestBeginDate = Date(timeIntervalSinceNow: 1 * 60) // Fetch no earlier than 15 minutes from now
        // request.requiresExternalPower = true
        do {
            try BGTaskScheduler.shared.submit(request)
            print("scheduleAppProcessingRefresh processing Scheduled")
        } catch {
            print("Could not schedule app processing: \(error)")
        }
    }
}

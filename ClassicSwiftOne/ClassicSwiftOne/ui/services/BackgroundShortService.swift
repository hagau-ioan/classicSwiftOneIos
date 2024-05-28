//
//  BackgroundService.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 20.05.2024.
//

import Foundation
import BackgroundTasks

class BackgroundShortService: NSObject {
    
    /*
     * Maximum 30 seconds duration
     */
    func start(task: BGAppRefreshTask) -> Task<Void, Error> {
        return Task {
            task.setTaskCompleted(success: await execute())
        }
    }
    
    func stop() {}
    
    private func execute() async -> Bool {
        await TaskUtils.delay(seconds: 10)
        print("Running a short service each 3 minutes????")
        return true
    }
    
}

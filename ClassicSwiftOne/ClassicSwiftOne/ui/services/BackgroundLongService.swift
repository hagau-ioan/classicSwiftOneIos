//
//  BackgroundService.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 20.05.2024.
//

import Foundation
import BackgroundTasks

class BackgroundLongService: NSObject {
    
    func start(task: BGProcessingTask) -> Task<Void, Error> {
        return Task {
            task.setTaskCompleted(success: await execute())
        }
    }
    
    func stop() {}
    
    private func execute() async -> Bool {
        await TaskUtils.delay(seconds: 100)
        print("Running a long service each 15 minutes????")
        return true
    }
    
}

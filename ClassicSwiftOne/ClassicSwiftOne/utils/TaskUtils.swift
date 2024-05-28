//
//  TaskUtils.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 20.05.2024.
//

import Foundation

struct TaskUtils {
    static func delay(seconds: Int) async {
        do {
            try await Task.sleep(nanoseconds: TimeUtils.getNanoSeconds(5))
        } catch  {
        }
    }
}

//
//  ThreadExt.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 24.04.2024.
//

import Foundation

struct TimeUtils {
    
    static func getNanoSeconds(_ seconds: Int) -> UInt64 {
        return UInt64(seconds * 1_000 * 1_000_000)
    }
    
    static func secondsToMinutes(_ seconds: TimeInterval) -> Double {
        seconds / 60.0
    }
    
    static func minutesToHours(_ minutes: TimeInterval) -> Double {
        minutes / 60.0
    }
    
    static func getNow() -> Double {
        let date = Date()
        let milliseconds = date.timeIntervalSince1970 * 1000
        return milliseconds
    }
    
    static func getFormatedDateSince1970(_ formatDateTime: String = "yyyy-MM-dd HH:mm:ss", miliseconds: Double) -> String {
        let date = Date(timeIntervalSince1970: (miliseconds / 1000.0))
        let formatter = DateFormatter()
        formatter.dateFormat = formatDateTime
        return formatter.string(from: date)
    }
}

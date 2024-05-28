//
//  URLSessionInterceptor.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 26.04.2024.
//

import Foundation

/**
 *  A third library to be used is: Alamofire for http request and interceptor
 */
class URLSessionInterceptor: NSObject, URLSessionDataDelegate, URLSessionTaskDelegate {
    
    func urlSession(_ session: URLSession, didCreateTask task: URLSessionTask) {
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
    }
}

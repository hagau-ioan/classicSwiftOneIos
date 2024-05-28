//
//  ProxyWSP.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 08.05.2024.
//

import Foundation

import Combine

class ProxyWSP {
    
    private var loadListUrlDataTask: URLSessionDataTask? = nil
    
    
    func loadListOfPosts() async -> Future<DataLoadingState<Post>, Never> {
        return Future { [weak self] promise in
            self?.loadListUrlDataTask?.cancel()
            let urlComponents = URLComponents(string: "https://gorest.co.in/public-api/posts")
            guard let requestComponent = urlComponents else {
                promise(.success(DataLoadingState.ERROR(errorCode: DataLoadingErrorCode.HTTP_ERROR)))
                return
            }
            var urlRequest = URLRequest(url: (requestComponent.url)!)
            urlRequest.httpMethod = "GET"
            urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            // Add more values to the header here like: key:Authorisation value:Bearer token....
            //        for (key, value) in headers {
            //            urlRequest.setValue(value, forHTTPHeaderField: key)
            //        }
            let config = URLSessionConfiguration.default
            
            // If the download process will take a lot of time and we need this to be run even after the app is in
            // inactive state (https://developer.apple.com/documentation/foundation/url_loading_system/downloading_files_in_the_background/ ) we need:
//            let config = URLSessionConfiguration.background(withIdentifier: "MySession")
//            config.isDiscretionary = true
//            config.sessionSendsLaunchEvents = true
            
            // Give a time of 10 seconds for the for data to arrive. Default is 60 seconds
            config.timeoutIntervalForRequest = 10
            // Give a time of 10 seconds for the whole resource request to complete.The default value is 7 days
            config.timeoutIntervalForResource = TimeUtils.secondsToMinutes(120)
            self?.loadListUrlDataTask = URLSession(configuration: config, delegate: URLSessionInterceptor(), delegateQueue: nil)
                // using default we can have full option for requests
                // There is also dataTaskPublisher which return a combined publisher
                // .downloadTask(with: <#T##URLRequest#>) OR
                .dataTask(with: urlRequest, completionHandler: { [weak self] content, response, error in
                    defer { // After the call and response is received we dismissed everything.
                        self?.loadListUrlDataTask?.cancel()
                        self?.loadListUrlDataTask = nil
                    }
                    if let error = error {
                        promise(.success(DataLoadingState.ERROR(errorCode: DataLoadingErrorCode.HTTP_ERROR)))
                        print(error)
                    } else if
                        let contentData = content,
                        let response = response as? HTTPURLResponse,
                        response.statusCode == 200 {
                        do {
                            let jsonToObject = try JSONDecoder().decode(ResponseData.self, from: contentData)
                            promise(.success(DataLoadingState.SUCCESS(dataLoaded: DataLoaded(data: jsonToObject.data))))
                        } catch {
                            promise(.success(DataLoadingState.ERROR(errorCode: DataLoadingErrorCode.DATA_PARSING_ERROR)))
                        }
                    }
                })
            // Atributes to inform the system about the amount of data payload will be procesed, 
            // because this is running in the background.
            // JSON data, blob content, zip file, etc .... with URLSessionConfiguration.background
//            self.loadListUrlDataTask?.countOfBytesClientExpectsToSend
//            self.loadListUrlDataTask?.countOfBytesClientExpectsToReceive
//            self.loadListUrlDataTask?.countOfBytesSent
//            self.loadListUrlDataTask?.countOfBytesReceived
            self?.loadListUrlDataTask?.resume()
        }
    }
}

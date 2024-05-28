//
//  DataLoading.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 24.04.2024.
//

import Foundation

struct DataLoaded<T: AnyObject> {
    var data: [T]
}

enum DataLoadingState<T: AnyObject> {
    case SUCCESS(dataLoaded: DataLoaded<T>)
    case ERROR(errorCode: DataLoadingErrorCode)
    case LOADING
    case NONE
}

enum DataLoadingErrorCode {
    case HTTP_ERROR
    case DATA_PARSING_ERROR
    case UNKNOWN_ERROR
}

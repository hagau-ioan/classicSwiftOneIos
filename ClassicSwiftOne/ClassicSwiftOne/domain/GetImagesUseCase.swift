//
//  GetImagesUseCase.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 08.05.2024.
//

import Foundation

import Combine

class GetImagesUseCase: NSObject {
    
    private var repository: RepositoryLocalStorage? = nil
    
    init(repository: RepositoryLocalStorage?) {
        self.repository = repository
    }
    
    func loadImages() async -> Future<DataLoadingState<ImageItem>, Never> {
        return Future { promise in
            Task {
                let result = await self.repository?.loadImages()
                var resultFound = [ImageItem]()
                guard let result else {
                    promise(.success(DataLoadingState.ERROR(errorCode: DataLoadingErrorCode.UNKNOWN_ERROR)))
                    return
                }
                for imageName in result {
                    resultFound.append(ImageItem(title: imageName, image: imageName, description: ""))
                }
                promise(.success(DataLoadingState.SUCCESS(dataLoaded: DataLoaded(data: resultFound))))
            }
        }
    }
    
}

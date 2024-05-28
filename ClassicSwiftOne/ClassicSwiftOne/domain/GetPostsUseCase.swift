//
//  GetPostsUseCase.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 26.04.2024.
//

import Foundation

import Combine

class GetPostsUseCase: NSObject {
    
    private var repository: RepositoryWSP? = nil
    
    init(repository: RepositoryWSP?) {
        self.repository = repository
    }
    
    func loadPosts() async -> Future<DataLoadingState<ImageItem>, Never> {
        return Future { promise in
            Task {
                let data = await self.repository?.loadListOfPosts()?.value
                switch(data) {
                case .SUCCESS(let dataloaded):
                    var resultFound = [ImageItem]()
                    let result = dataloaded.data
                    for item in result {
                        resultFound.append(ImageItem(title: item.title, image: "nssl0033", description: item.description))
                    }
                    promise(.success(DataLoadingState.SUCCESS(dataLoaded: DataLoaded(data: resultFound))))
                case .LOADING:
                    promise(.success(DataLoadingState.LOADING))
                case .ERROR(let errorCode):
                    promise(.success(DataLoadingState.ERROR(errorCode: errorCode)))
                default:
                    promise(.success(DataLoadingState.ERROR(errorCode: DataLoadingErrorCode.UNKNOWN_ERROR)))
                }
            }
            
        }
    }
}

//
//  GetUserUseCase.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 16.05.2024.
//

import Foundation

class GetUserUseCase: NSObject {
    
    private var dbRepo: RepositoryDataBase? = nil
    
    init(dbRepo: RepositoryDataBase?) {
        self.dbRepo = dbRepo
    }
    
    func test() async {
        await dbRepo?.test()
    }
}

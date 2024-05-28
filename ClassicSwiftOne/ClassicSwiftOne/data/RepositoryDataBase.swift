//
//  RepositoryDataBase.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 16.05.2024.
//

import Foundation
import Combine

class RepositoryDataBase {
    
    private var dataBase: DataBaseController? = nil

    init(dataBase: DataBaseController?) {
        self.dataBase = dataBase
    }
    
    func test() async {
        await dataBase?.testDatabaseWork()
    }
    
}

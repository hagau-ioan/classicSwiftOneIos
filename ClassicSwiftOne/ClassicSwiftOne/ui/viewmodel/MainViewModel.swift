//
//  MainViewModel.swift
//  ClassicSwiftOne
//
//  Created by Ioan Hagau on 21.08.2024.
//

import Foundation

class MainViewModel: ObservableObject {
    
    @Published var testing = "a testing text to be displayed as detail"
    @Published var isProductDetailVisible = false
    
    init () {
       
    }
    
    func test() {
        Task {
            await TaskUtils.delay(seconds: 3000)
            await MainActor.run {
                testing = "new value after 3000 miliseconds"
            }
            
        }
    }
}

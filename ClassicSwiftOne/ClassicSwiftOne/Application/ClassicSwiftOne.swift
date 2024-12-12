//
//  ClassicSwiftOne.swift
//  ClassicSwiftOne
//
//  Created by Ioan Hagau on 21.08.2024.
//

import SwiftUI
import Swinject

@main
struct ClassicSwiftOne: App {
    
    var viewModel = diUI.resolve(MainViewModel.self)
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appdelegate
    
    var body: some Scene {
        WindowGroup {
            MainContentView()
            .environmentObject(viewModel!)
            .onAppear {
//                viewModel?.test()
            }.onDisappear {
                
            }
        }
    }
}

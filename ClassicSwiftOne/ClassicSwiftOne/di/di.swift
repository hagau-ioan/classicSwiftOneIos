//
//  di.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 26.04.2024.
//

import Foundation
import Swinject
/**
 * Register all UI dependencies to be accessed and used in the UI layer.
 */
// DI related only to UI
let diUI: Container = { // Not a singletone
    let container = Container()
    container.register(MainViewModel.self) { _ in
        let viewModel = MainViewModel(
            postsUseCase: diDomain.resolve(GetPostsUseCase.self),
            imagesUseCase: diDomain.resolve(GetImagesUseCase.self),
            settings: diDomain.resolve(GetUserSettingsUseCase.self),
            keyChain: diDomain.resolve(GetKeyChainPasswordUseCase.self),
            userUsercase: diDomain.resolve(GetUserUseCase.self)
        )
        return viewModel
    }
    container.register(FirstScreenViewController.self) { r in
        let controller = FirstScreenViewController()
        controller.viewModel = r.resolve(MainViewModel.self)
        return controller
    }
    container.register(SplashViewController.self) { r in
        let controller = SplashViewController()
        controller.viewModel = r.resolve(MainViewModel.self)
        return controller
    }
    
    return container
}()

// DI related to Data layer
let diData: Container = { // Not a singletone
    let container = Container()
    
    container.register(ProxyWSP.self) { _ in
        // Ex: ProxyWSP --> Will be provided as singletone.
        // To provide always a NEW instance {....}.inObjectScope(.transient) need to be used.
        ProxyWSP()
    }
    
    container.register(LocalStorageData.self) { _ in
        LocalStorageData()
    }
    
    container.register(RepositoryWSP.self) { r in
        RepositoryWSP(proxy: r.resolve(ProxyWSP.self) ?? nil)
    }
    container.register(RepositoryLocalStorage.self) { r in
        RepositoryLocalStorage(localStorage: r.resolve(LocalStorageData.self) ?? nil)
    }
    container.register(UserSettingsDefaults.self) { r in
        UserSettingsDefaults()
    }
    container.register(KeyChainPassword.self) { r in
        KeyChainPassword()
    }
    container.register(DataBaseController.self) { r in
        DataBaseController.shared
    }
    container.register(RepositoryDataBase.self) { r in
        RepositoryDataBase(dataBase: r.resolve(DataBaseController.self) ?? nil)
    }
    return container
}()

// DI related to Domain layer
let diDomain: Container = { // Not a singletone
    let container = Container()
    
    container.register(GetImagesUseCase.self) { _ in
        GetImagesUseCase(repository: diData.resolve(RepositoryLocalStorage.self) ?? nil)
    }
    container.register(GetPostsUseCase.self) { _ in
        GetPostsUseCase(repository: diData.resolve(RepositoryWSP.self) ?? nil)
    }
    container.register(GetUserSettingsUseCase.self) { _ in
        GetUserSettingsUseCase(settings: diData.resolve(UserSettingsDefaults.self) ?? nil)
    }
    container.register(GetKeyChainPasswordUseCase.self) { _ in
        GetKeyChainPasswordUseCase(keyChain: diData.resolve(KeyChainPassword.self) ?? nil)
    }
    container.register(GetUserUseCase.self) { _ in
        GetUserUseCase(dbRepo: diData.resolve(RepositoryDataBase.self) ?? nil)
    }
    return container
}()

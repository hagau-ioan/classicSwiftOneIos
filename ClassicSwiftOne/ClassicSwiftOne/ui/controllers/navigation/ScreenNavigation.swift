//
//  ScreenNavigation.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 23.04.2024.
//

import UIKit
import Swinject

class ScreenNavigation {
    
    static let shared = ScreenNavigation()
    
    func openWebViewScreen(navigationController: UINavigationController?) {
        let vc = WebViewController()
        getRootViewController()?.pushViewController(vc, animated: true)
    }
    
    func openDetailsScreen(
        navigationController: UINavigationController?,
        picture: ImageItem,
        writeBackValueDelegate: any WriteValueBackDelegate) {
            
            let vc = DetailsScreenViewController()
            vc.setArg(arg: ScreenDetailsArg(imageName: picture))
            vc.writeBackValueDelegate(writeBackValueDelegate)
            navigationController?.pushViewController(vc, animated: true)
        }
    
    func switchNavigationRooterToHomeScreen() {
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
        sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: diUI.resolve(FirstScreenViewController.self)!)
    }
    
    func switchNavigationRooterToSplashScreen() {
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
        sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: diUI.resolve(SplashViewController.self)!)
    }
    
    func getRootViewController() -> UINavigationController? {
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
        return sceneDelegate.window?.rootViewController as? UINavigationController
    }
}

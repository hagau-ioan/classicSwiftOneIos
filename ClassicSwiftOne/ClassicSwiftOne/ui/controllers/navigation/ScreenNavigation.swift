//
//  ScreenNavigation.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 23.04.2024.
//

import UIKit

class ScreenNavigation {
    
    static let instance = ScreenNavigation()
    
    func openDetailsScreen(
        navigationController: UINavigationController?,
        picture: ImageItem,
        writeBackValueDelegate: any WriteValueBackDelegate) {
            
            let vc = DetailsScreenViewController()
            vc.setArg(arg: ScreenDetailsArg(imageName: picture))
            vc.writeBackValueDelegate(writeBackValueDelegate)
            navigationController?.pushViewController(vc, animated: true)
            
        }
}

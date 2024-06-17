//
//  SplashViewController.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 17.06.2024.
//

import Foundation
import UIKit

class SplashViewController: UIViewController {
    
    // @Inject
    var viewModel: MainViewModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.contentMode = .center
        let backgroundImageView = UIImageView(image: UIImage(named: "parrots-logo"))
        
        backgroundImageView.frame = view.frame
        backgroundImageView.contentMode = .center
        
        
        view.backgroundColor = UIColor.white
        
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
        
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(splashTimeOut(sender:)), userInfo: nil, repeats: false)
    }

    @objc func splashTimeOut(sender : Timer){
        ScreenNavigation.shared.switchNavigationRooterToHomeScreen()
    }
}

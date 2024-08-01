//
//  SplashViewController.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 17.06.2024.
//

import Foundation
import UIKit

class SplashViewController: UIViewController {
    
    var spinner: UIActivityIndicatorView? = nil
    
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
        
        // Example of adding a spinner in the middle of the screen with a color and size.
        spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        spinner?.color = UIColor.red
        spinner?.transform = CGAffineTransform(scaleX: 3, y: 3)
        if let spinner = spinner {
            spinner.center = view.center
            view.addSubview(spinner)
            spinner.startAnimating()
        }
        
        backgroundImageView.alpha = 1
        UIView.animate(withDuration: 2) {
            backgroundImageView.alpha = 0
        }
        
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(splashTimeOut(sender:)), userInfo: nil, repeats: false)
    }

    @objc func splashTimeOut(sender : Timer){
        if let spinner = spinner {
            spinner.stopAnimating()
            view.addSubview(spinner)
        }
        ScreenNavigation.shared.switchNavigationRooterToHomeScreen()
    }
}

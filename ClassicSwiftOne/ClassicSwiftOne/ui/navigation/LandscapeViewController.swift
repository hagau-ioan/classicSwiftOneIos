//
//  LandscapeViewController.swift
//  ClassicSwiftOne
//
//  Created by Ioan Hagau on 26.08.2024.
//

import UIKit

class LandscapeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Force landscape orientation
//        UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
        guard let windowScene = view.window?.windowScene else { return }
        windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: .landscape)) { error in
            // Handle denial of request.
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
}

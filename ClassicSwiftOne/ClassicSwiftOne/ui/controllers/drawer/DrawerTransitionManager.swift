//
//  DrawerTransitionManager.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 03.06.2024.
//

import Foundation

import UIKit
class DrawerTransitionManager: NSObject, UIViewControllerTransitioningDelegate {
    
    let slideAnimation = DrawerSlideAnimation()
    var drawerController: DrawerPresentationController?
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        drawerController = DrawerPresentationController(presentedViewController: presented, presenting: presenting)
        return drawerController
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        slideAnimation.isPresenting = true
        return slideAnimation
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        slideAnimation.isPresenting = false
        return slideAnimation
    }
    
    func dismiss() {
        drawerController?.dismiss()
    }
    
}

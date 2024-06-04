//
//  DrawerSlideAnimation.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 03.06.2024.
//

import Foundation

import UIKit
class DrawerSlideAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresenting: Bool = true
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let key: UITransitionContextViewControllerKey = isPresenting ? .to : .from
        
        // check if our controller exist in transition
        guard let presentedController = transitionContext.viewController(forKey: key) else {
            return
        }
        // for convenience set containerView to new variable
        let containerView = transitionContext.containerView
        // define position and size of drawer at the end of presentation
        let presentedFrame = transitionContext.finalFrame(for: presentedController)
        // define position and size of drawer at the end of dismiss
        // just offset presentedFrame by its width to left
        let dismissedFrame = presentedFrame.offsetBy(dx: -presentedFrame.width, dy: 0)
        // if we are going to present controller, we need to add its view to the container
        if isPresenting {
            containerView.addSubview(presentedController.view)
        }
        // get actual duration for animation, defined in the function above
        let duration = transitionDuration(using: transitionContext)
        // we need to notify that transition is finished with status from the context, not our custom animation
        let wasCancelled = transitionContext.transitionWasCancelled
        // define start and end frames for animation
        let fromFrame = isPresenting ? dismissedFrame : presentedFrame
        let toFrame = isPresenting ? presentedFrame : dismissedFrame
        // set start frame for controller view before animation
        presentedController.view.frame = fromFrame
        UIView.animate(withDuration: duration) {
            // change controller view frame to end frame during animation
            presentedController.view.frame = toFrame
        } completion: { (_) in
            // notify animation complete with context status
            transitionContext.completeTransition(!wasCancelled)
        }
    }
    
}

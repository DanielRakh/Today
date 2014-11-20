//
//  DRTransitionAnimator.swift
//  Today
//
//  Created by Daniel on 11/19/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit

class DRTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
   
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        
        return 1.0
    }

    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        let containerView = transitionContext.containerView()
        
        let animationDuration = transitionDuration(transitionContext)
        
        toView.frame = CGRectMake(fromView.bounds.size.width, fromView.frame.origin.y, toView.bounds.size.width, toView.bounds.size.height)
        containerView.addSubview(fromView)
        containerView.addSubview(toView)
    
        UIView.animateWithDuration(animationDuration,
            delay: 0.0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.5,
            options: .CurveEaseInOut,
            animations: { () -> Void in
                fromView.frame = CGRectMake(-fromView.bounds.size.width, fromView.frame.origin.y, fromView.bounds.size.width, fromView.bounds.size.height)
                toView.frame = CGRectMake(-toView.bounds.size.width, toView.frame.origin.y, toView.bounds.size.width, toView.bounds.size.height)
            }) { (success:Bool) -> Void in
            transitionContext.completeTransition(true)
        }
        
    }
}

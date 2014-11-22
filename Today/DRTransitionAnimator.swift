//
//  DRTransitionAnimator.swift
//  Today
//
//  Created by Daniel on 11/19/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit

class DRTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    
    var mode:Mode!
    /*
    func newViewStartFrameForMode(mode:Mode) -> CGRect! {
        switch mode {
        case .Do:
            return CGRectMake(-doVC.view.bounds.size.width, view.frame.origin.y, doVC.view.bounds.size.width, doVC.view.bounds.size.height)
            
        case .Dont:
            return CGRectMake(dontVC.view.bounds.size.width, view.frame.origin.y, dontVC.view.bounds.size.width, dontVC.view.bounds.size.height)
        default:
            println("There was an error geting the new view start frame")
            
        }
        
        return nil
    }
    */
   
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        
        return 1.0
    }

    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {

        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        let containerView = transitionContext.containerView()
        
        let animationDuration = transitionDuration(transitionContext)
        
        var fromViewStartFrame:CGRect?
        var fromViewEndFrame:CGRect?
        var toViewStartFrame:CGRect?
        var toViewEndFrame:CGRect?
        
        if mode == Mode.Do {
            toViewStartFrame = CGRectMake(-toView.bounds.size.width, toView.frame.origin.y, toView.bounds.size.width, toView.bounds.size.height)
            toViewEndFrame = CGRectMake(0, 0, toView.bounds.size.width, toView.bounds.size.height)
            fromViewStartFrame = CGRectMake(0, 0, fromView.bounds.size.width, fromView.bounds.size.height)
            fromViewEndFrame = CGRectMake(fromView.bounds.size.width, fromView.frame.origin.y, fromView.bounds.size.width, fromView.bounds.size.height)
            
        } else if mode == Mode.Dont {
            toViewStartFrame = CGRectMake(toView.bounds.size.width, toView.frame.origin.y, toView.bounds.size.width, toView.bounds.size.height)
            toViewEndFrame = CGRectMake(0, 0, toView.bounds.size.width, toView.bounds.size.height)
            fromViewStartFrame = CGRectMake(0, 0, fromView.bounds.size.width, fromView.bounds.size.height)
            fromViewEndFrame = CGRectMake(-fromView.bounds.size.width, fromView.frame.origin.y, fromView.bounds.size.width, fromView.bounds.size.height)
        }
        
        toView.frame = toViewStartFrame!
        containerView.addSubview(toView)
    
        UIView.animateWithDuration(animationDuration,
            delay: 0.0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.5,
            options: .CurveEaseInOut,
            animations: { () -> Void in
                fromView.frame = fromViewEndFrame!
                toView.frame = toViewEndFrame!
            }) { (success:Bool) -> Void in
            transitionContext.completeTransition(true)
        }
        
    }
}

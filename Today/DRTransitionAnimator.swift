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
    private var fromView:UIView!
    private var toView:UIView!
    private var containerView:UIView!
    
    private enum Position {
        case Left
        case Right
    }
    
    private func frameForView(view:UIView, offScreenPosition:Position) -> CGRect {
        let xPosition = offScreenPosition == .Left ? -view.bounds.size.width : view.bounds.size.width
        return CGRectMake(xPosition, view.frame.origin.y, view.bounds.size.width, view.bounds.size.height)
    }
    
    private func framesForMode(mode:Mode) -> (toStartFrame:CGRect, fromEndFrame:CGRect) {
        
        if mode == .Do {
            return (
                frameForView(toView, offScreenPosition: .Left),
                frameForView(fromView, offScreenPosition: .Right)
            )
        } else if mode == .Dont {
            return (
                frameForView(toView, offScreenPosition: .Right),
                frameForView(fromView, offScreenPosition: .Left)
            )
        }
        
        return (CGRectZero,CGRectZero)
        
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        
        return 0.8
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let animationDuration = transitionDuration(transitionContext)
        
        fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        containerView = transitionContext.containerView()
        
        var toViewEndFrame:CGRect = CGRectMake(0, 0, toView.bounds.size.width, toView.bounds.size.height)
        
        let (toViewStartFrame, fromViewEndFrame) = framesForMode(mode)
        
        toView.frame = toViewStartFrame
        
        containerView.addSubview(toView)
        
        UIView.animateWithDuration(animationDuration,
            delay: 0.0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0.5,
            options: .CurveEaseInOut,
            animations: { () -> Void in
                self.fromView.frame = fromViewEndFrame
                self.toView.frame = toViewEndFrame
            }) { (success:Bool) -> Void in
                transitionContext.completeTransition(true)
        }
    }
}

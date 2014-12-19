//
//  DRTransitionSpringPopAnimator.swift
//  Today
//
//  Created by Daniel on 12/18/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit

class DRTransitionSpringPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    enum TransitionType {
        case Present
        case Dismiss
    }
    
    var transitionType:TransitionType
    
    init(transitionType:TransitionType) {
        self.transitionType = transitionType
    }
    
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0
    }
    
    /*
    
    NSObject.pop_animate({ () -> Void in
    (self.navController.topViewController.view).pop_spring().alpha = 0
    self.navBar.pop_spring().alpha = 0
    self.addEntryButton.pop_spring().pop_scaleXY = CGPointMake(1.2, 1.2)
    }, completion: { (success:Bool) -> Void in
    NSObject.pop_animate({ () -> Void in
    (self.navController.topViewController.view).pop_spring().pop_scaleXY = CGPointMake(0, 0)
    self.addEntryButton.pop_spring().pop_scaleXY = CGPointMake(0, 0)
    }, completion: { (success:Bool) -> Void in
    self.performSegueWithIdentifier("presentAddEntryVC", sender: self)
    })
    
    })


*/
    
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        let containerView = transitionContext.containerView()
        
        toView.alpha = 0.0
        toView.frame = CGRectMake(0, 0, toView.bounds.size.width, toView.bounds.size.height)
        containerView.addSubview(toView)
        
        
        
        
        
        UIView.animateWithDuration(transitionDuration(transitionContext),
            delay: 0.0,
            options: .CurveEaseInOut,
            animations: { () -> Void in
                fromView.alpha = 0.0
                toView.alpha = 1.0
            }) { (success:Bool) -> Void in
                transitionContext.completeTransition(success)
        }
        
    }
    
}

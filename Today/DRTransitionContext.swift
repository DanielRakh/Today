//
//  DRTransitionContext.swift
//  Today
//
//  Created by Daniel on 11/22/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import Foundation

extension DRMasterViewController: UIViewControllerContextTransitioning {
    
    func containerView() -> UIView {
        return innerContainerView
    }
    func isAnimated() -> Bool { return true }
    
    func isInteractive() -> Bool  { return false }
    
    func transitionWasCancelled() -> Bool { return false }
    
    func presentationStyle() -> UIModalPresentationStyle {
        return .Custom
    }
    func completeTransition(didComplete: Bool) {
        if didComplete == true {
            fromViewController?.view.removeFromSuperview()
            fromViewController?.endAppearanceTransition()
            toViewController?.endAppearanceTransition()
            fromViewController?.removeFromParentViewController
            toViewController?.didMoveToParentViewController(self)
        } else {
            fromViewController?.endAppearanceTransition()
            toViewController?.endAppearanceTransition()
        }
        
        fromViewController = nil
        toViewController = nil
    }
    func viewControllerForKey(key: String) -> UIViewController? {
        if key == UITransitionContextFromViewControllerKey {
            return fromViewController
        } else if key == UITransitionContextToViewControllerKey {
            return toViewController
        }
        return nil
    }
    func viewForKey(key: String) -> UIView? {
        if key == UITransitionContextFromViewKey {
            return fromViewController?.view
        } else if key == UITransitionContextToViewKey {
            return toViewController?.view
        }
        return nil
    }
    func targetTransform() -> CGAffineTransform {
        return CGAffineTransformIdentity
    }
    func initialFrameForViewController(vc: UIViewController) -> CGRect {
        return CGRectZero
    }
    func finalFrameForViewController(vc: UIViewController) -> CGRect {
        return CGRectZero
    }
    func updateInteractiveTransition(percentComplete: CGFloat) {}
    func finishInteractiveTransition() {}
    func cancelInteractiveTransition() {}
    
    
}



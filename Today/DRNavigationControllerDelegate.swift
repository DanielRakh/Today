//
//  DRNavigationControllerDelegate.swift
//  Today
//
//  Created by Daniel on 12/1/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit

class DRNavigationControllerDelegate: NSObject, UINavigationControllerDelegate {
    
    lazy private var transitionAnimator = DRTransitionAnimator()
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        switch operation {
        case .Push:
            transitionAnimator.mode = .Dont
        case .Pop:
            transitionAnimator.mode = .Do
        default:
            println("There was an error transitioning with the nav controller")
        }

        return transitionAnimator
    }
    
}

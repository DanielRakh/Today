//
//  UIView+SpringAnimations.swift
//  Today
//
//  Created by Daniel on 12/22/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import Foundation

/**
    This extension requires you to have pop.
    See: https://github.com/facebook/pop
*/

extension UIView {
    
    /**
    A scale animation using POP + MCAnimate
    
    :param springBounciness: Use in conjunction with 'springSpeed' to change animation effect. Values are converted into corresponding dynamics constants. Defined as a value in the range [0, 20]. Defaults to 18 when nil.
    :param springSpeed: Use in conjunction with 'springBounciness' to change animation effect. Values are converted into corresponding dynamics constants. Defined as a value in the range [0, 20]. Defaults to 16 when nil.
    :param reveal: Pass in "true" to have the view grow as it animates. Pass in "false" to shrink the view as it animates.

    */
    
    func animateScaleWithSpringPOP(springBounciness:CGFloat?, springSpeed:CGFloat?, reveal:Bool) {
        
        let toScale:CGFloat = reveal == true ? 1 : 0
        
        let anim:AnyObject? = self.pop_animationForKey("IconSpring")
        if anim != nil {
            self.pop_removeAnimationForKey("IconSpring")
        }
        
        let popSpring = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
        popSpring.springBounciness = springBounciness == nil ? 16 : springBounciness!
        popSpring.springSpeed = springSpeed == nil ? 18 : springSpeed!

        if reveal == true {
            popSpring.toValue = NSValue(CGPoint:CGPointMake(1,1)) as NSValue
        } else {
            popSpring.clampMode = 3
            popSpring.toValue = NSValue(CGPoint:CGPointMake(0.001, 0.001)) as NSValue
        }
        
        self.pop_addAnimation(popSpring, forKey: "IconSpring")

    }
}
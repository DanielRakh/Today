//
//  DRNotificationIconView.swift
//  Today
//
//  Created by Daniel on 11/17/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit

@IBDesignable class DRAlertOnIconView: DRGradientGlyphIconView {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        iconMode = .Off
        todayMode = .Do
        shapePath = iconShape()
    }
    
    func iconShape() -> UIBezierPath {
        var bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(5.6, 1.6))
        bezier2Path.addLineToPoint(CGPointMake(4.2, 0.2))
        bezier2Path.addCurveToPoint(CGPointMake(0, 8), controlPoint1: CGPointMake(1.8, 2), controlPoint2: CGPointMake(0.2, 4.8))
        bezier2Path.addLineToPoint(CGPointMake(2, 8))
        bezier2Path.addCurveToPoint(CGPointMake(5.6, 1.6), controlPoint1: CGPointMake(2.2, 5.3), controlPoint2: CGPointMake(3.5, 3))
        bezier2Path.closePath()
        bezier2Path.moveToPoint(CGPointMake(19, 8))
        bezier2Path.addLineToPoint(CGPointMake(21, 8))
        bezier2Path.addCurveToPoint(CGPointMake(16.9, 0.2), controlPoint1: CGPointMake(20.8, 4.8), controlPoint2: CGPointMake(19.3, 2))
        bezier2Path.addLineToPoint(CGPointMake(15.5, 1.6))
        bezier2Path.addCurveToPoint(CGPointMake(19, 8), controlPoint1: CGPointMake(17.5, 3), controlPoint2: CGPointMake(18.8, 5.3))
        bezier2Path.closePath()
        bezier2Path.moveToPoint(CGPointMake(17, 8.5))
        bezier2Path.addCurveToPoint(CGPointMake(12, 2.2), controlPoint1: CGPointMake(17, 5.4), controlPoint2: CGPointMake(14.9, 2.9))
        bezier2Path.addLineToPoint(CGPointMake(12, 1.5))
        bezier2Path.addCurveToPoint(CGPointMake(10.5, 0), controlPoint1: CGPointMake(12, 0.7), controlPoint2: CGPointMake(11.3, 0))
        bezier2Path.addCurveToPoint(CGPointMake(9, 1.5), controlPoint1: CGPointMake(9.7, 0), controlPoint2: CGPointMake(9, 0.7))
        bezier2Path.addLineToPoint(CGPointMake(9, 2.2))
        bezier2Path.addCurveToPoint(CGPointMake(4, 8.5), controlPoint1: CGPointMake(6.1, 2.9), controlPoint2: CGPointMake(4, 5.4))
        bezier2Path.addLineToPoint(CGPointMake(4, 14))
        bezier2Path.addLineToPoint(CGPointMake(2, 16))
        bezier2Path.addLineToPoint(CGPointMake(2, 17))
        bezier2Path.addLineToPoint(CGPointMake(19, 17))
        bezier2Path.addLineToPoint(CGPointMake(19, 16))
        bezier2Path.addLineToPoint(CGPointMake(17, 14))
        bezier2Path.addLineToPoint(CGPointMake(17, 8.5))
        bezier2Path.closePath()
        bezier2Path.moveToPoint(CGPointMake(10.5, 20))
        bezier2Path.addCurveToPoint(CGPointMake(10.9, 20), controlPoint1: CGPointMake(10.6, 20), controlPoint2: CGPointMake(10.8, 20))
        bezier2Path.addCurveToPoint(CGPointMake(12.3, 18.8), controlPoint1: CGPointMake(11.6, 19.9), controlPoint2: CGPointMake(12.1, 19.4))
        bezier2Path.addCurveToPoint(CGPointMake(12.5, 18), controlPoint1: CGPointMake(12.4, 18.6), controlPoint2: CGPointMake(12.5, 18.3))
        bezier2Path.addLineToPoint(CGPointMake(8.5, 18))
        bezier2Path.addCurveToPoint(CGPointMake(10.5, 20), controlPoint1: CGPointMake(8.5, 19.1), controlPoint2: CGPointMake(9.4, 20))
        bezier2Path.closePath()
        bezier2Path.miterLimit = 4;
        
        return bezier2Path
    }
    
    
    override func originalSize() -> CGSize {
        return CGSizeMake(21, 20)
    }

}

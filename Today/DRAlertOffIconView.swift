//
//  DRAlertOffIconView.swift
//  Today
//
//  Created by Daniel on 12/7/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit

@IBDesignable class DRAlertOffIconView: MMScalableVectorView {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        backgroundColor = UIColor.clearColor()
    }
    
    override func drawInCurrentContext() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Color Declarations
        let gradientColor = UIColor(red: 0.286, green: 0.831, blue: 0.486, alpha: 1.000)
        let gradientColor2 = UIColor(red: 0.231, green: 0.800, blue: 0.620, alpha: 1.000)
        
        //// Gradient Declarations
        let gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [gradientColor.CGColor, gradientColor2.CGColor], [0, 1])
        
        //// Bezier 2 Drawing
        var bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(8.5, 20))
        bezier2Path.addCurveToPoint(CGPointMake(10.5, 18), controlPoint1: CGPointMake(9.6, 20), controlPoint2: CGPointMake(10.5, 19.1))
        bezier2Path.addLineToPoint(CGPointMake(6.5, 18))
        bezier2Path.addCurveToPoint(CGPointMake(8.5, 20), controlPoint1: CGPointMake(6.5, 19.1), controlPoint2: CGPointMake(7.4, 20))
        bezier2Path.closePath()
        bezier2Path.moveToPoint(CGPointMake(15, 8.5))
        bezier2Path.addCurveToPoint(CGPointMake(10, 2.2), controlPoint1: CGPointMake(15, 5.4), controlPoint2: CGPointMake(12.9, 2.9))
        bezier2Path.addLineToPoint(CGPointMake(10, 1.5))
        bezier2Path.addCurveToPoint(CGPointMake(8.5, 0), controlPoint1: CGPointMake(10, 0.7), controlPoint2: CGPointMake(9.3, 0))
        bezier2Path.addCurveToPoint(CGPointMake(7, 1.5), controlPoint1: CGPointMake(7.7, 0), controlPoint2: CGPointMake(7, 0.7))
        bezier2Path.addLineToPoint(CGPointMake(7, 2.2))
        bezier2Path.addCurveToPoint(CGPointMake(5.6, 2.7), controlPoint1: CGPointMake(6.5, 2.3), controlPoint2: CGPointMake(6, 2.5))
        bezier2Path.addLineToPoint(CGPointMake(15, 12.1))
        bezier2Path.addLineToPoint(CGPointMake(15, 8.5))
        bezier2Path.closePath()
        bezier2Path.moveToPoint(CGPointMake(14.7, 17))
        bezier2Path.addLineToPoint(CGPointMake(16.7, 19))
        bezier2Path.addLineToPoint(CGPointMake(18, 17.7))
        bezier2Path.addLineToPoint(CGPointMake(1.3, 1))
        bezier2Path.addLineToPoint(CGPointMake(0, 2.3))
        bezier2Path.addLineToPoint(CGPointMake(2.9, 5.2))
        bezier2Path.addCurveToPoint(CGPointMake(2, 8.5), controlPoint1: CGPointMake(2.3, 6.2), controlPoint2: CGPointMake(2, 7.3))
        bezier2Path.addLineToPoint(CGPointMake(2, 14))
        bezier2Path.addLineToPoint(CGPointMake(0, 16))
        bezier2Path.addLineToPoint(CGPointMake(0, 17))
        bezier2Path.addLineToPoint(CGPointMake(14.7, 17))
        bezier2Path.closePath()
        bezier2Path.miterLimit = 4;
        
        CGContextSaveGState(context)
        bezier2Path.addClip()
        CGContextDrawLinearGradient(context, gradient, CGPointMake(9, -0), CGPointMake(9, 20), 0)
        CGContextRestoreGState(context)

    }
    
    
    override func originalSize() -> CGSize {
        return CGSizeMake(18, 20)
    }

}

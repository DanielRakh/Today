//
//  DRNotificationIconView.swift
//  Today
//
//  Created by Daniel on 11/17/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit

@IBDesignable class DRNotificationIconView: MMScalableVectorView {
    
    @IBInspectable var glyphColor:UIColor = UIColor.todayLightBlue()
    
    override func prepareForInterfaceBuilder() {
        backgroundColor = UIColor.clearColor()
    }
    
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
        let color0 = glyphColor

        var shapePath = UIBezierPath()
        shapePath.moveToPoint(CGPointMake(20.61, 30.52))
        shapePath.addCurveToPoint(CGPointMake(21.47, 20.71), controlPoint1: CGPointMake(18.14, 27.57), controlPoint2: CGPointMake(18.53, 23.18))
        shapePath.addCurveToPoint(CGPointMake(31.28, 21.57), controlPoint1: CGPointMake(24.42, 18.24), controlPoint2: CGPointMake(28.8, 18.63))
        shapePath.addCurveToPoint(CGPointMake(30.42, 31.37), controlPoint1: CGPointMake(33.75, 24.51), controlPoint2: CGPointMake(33.36, 28.9))
        shapePath.addCurveToPoint(CGPointMake(20.61, 30.52), controlPoint1: CGPointMake(27.47, 33.84), controlPoint2: CGPointMake(23.08, 33.46))
        shapePath.addLineToPoint(CGPointMake(20.61, 30.52))
        shapePath.closePath()
        shapePath.moveToPoint(CGPointMake(0.01, 23.77))
        shapePath.addCurveToPoint(CGPointMake(1.84, 25.95), controlPoint1: CGPointMake(-0.09, 24.88), controlPoint2: CGPointMake(0.73, 25.85))
        shapePath.addCurveToPoint(CGPointMake(4.01, 24.12), controlPoint1: CGPointMake(2.94, 26.05), controlPoint2: CGPointMake(3.92, 25.23))
        shapePath.addCurveToPoint(CGPointMake(11.79, 9.18), controlPoint1: CGPointMake(4.53, 18.26), controlPoint2: CGPointMake(7.29, 12.96))
        shapePath.addCurveToPoint(CGPointMake(27.86, 4.11), controlPoint1: CGPointMake(16.3, 5.39), controlPoint2: CGPointMake(22, 3.6))
        shapePath.addCurveToPoint(CGPointMake(30.04, 2.28), controlPoint1: CGPointMake(28.97, 4.21), controlPoint2: CGPointMake(29.95, 3.39))
        shapePath.addCurveToPoint(CGPointMake(29.58, 0.81), controlPoint1: CGPointMake(30.09, 1.73), controlPoint2: CGPointMake(29.91, 1.21))
        shapePath.addCurveToPoint(CGPointMake(28.22, 0.1), controlPoint1: CGPointMake(29.25, 0.42), controlPoint2: CGPointMake(28.76, 0.15))
        shapePath.addCurveToPoint(CGPointMake(9.2, 6.1), controlPoint1: CGPointMake(21.28, -0.51), controlPoint2: CGPointMake(14.54, 1.62))
        shapePath.addCurveToPoint(CGPointMake(0.01, 23.77), controlPoint1: CGPointMake(3.88, 10.56), controlPoint2: CGPointMake(0.61, 16.84))
        shapePath.addLineToPoint(CGPointMake(0.01, 23.77))
        shapePath.closePath()
        shapePath.moveToPoint(CGPointMake(8.53, 24.52))
        shapePath.addCurveToPoint(CGPointMake(10.35, 26.69), controlPoint1: CGPointMake(8.43, 25.62), controlPoint2: CGPointMake(9.25, 26.6))
        shapePath.addCurveToPoint(CGPointMake(12.54, 24.86), controlPoint1: CGPointMake(11.46, 26.79), controlPoint2: CGPointMake(12.44, 25.97))
        shapePath.addCurveToPoint(CGPointMake(17.29, 15.73), controlPoint1: CGPointMake(12.85, 21.28), controlPoint2: CGPointMake(14.54, 18.04))
        shapePath.addCurveToPoint(CGPointMake(27.12, 12.63), controlPoint1: CGPointMake(20.05, 13.42), controlPoint2: CGPointMake(23.54, 12.32))
        shapePath.addCurveToPoint(CGPointMake(29.3, 10.8), controlPoint1: CGPointMake(28.23, 12.72), controlPoint2: CGPointMake(29.2, 11.9))
        shapePath.addCurveToPoint(CGPointMake(28.84, 9.33), controlPoint1: CGPointMake(29.35, 10.24), controlPoint2: CGPointMake(29.17, 9.72))
        shapePath.addCurveToPoint(CGPointMake(27.47, 8.62), controlPoint1: CGPointMake(28.51, 8.94), controlPoint2: CGPointMake(28.03, 8.66))
        shapePath.addCurveToPoint(CGPointMake(14.71, 12.64), controlPoint1: CGPointMake(22.81, 8.21), controlPoint2: CGPointMake(18.29, 9.64))
        shapePath.addCurveToPoint(CGPointMake(8.53, 24.52), controlPoint1: CGPointMake(11.13, 15.65), controlPoint2: CGPointMake(8.93, 19.86))
        shapePath.addLineToPoint(CGPointMake(8.53, 24.52))
        shapePath.closePath()
        shapePath.miterLimit = 4;
        
        shapePath.usesEvenOddFillRule = true;
        
        color0.setFill()
        shapePath.fill()
    }
    
    override func originalSize() -> CGSize {
        return CGSizeMake(33, 33)
    }

}

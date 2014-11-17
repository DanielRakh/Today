//
//  DRCheckmarkIcon.swift
//  Today
//
//  Created by Daniel on 11/17/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit

@IBDesignable class DRCheckmarkIcon: MMScalableVectorView {
    
    override func drawInCurrentContext() {
        //// Color Declarations
        let color = UIColor(red: 0.976, green: 0.000, blue: 0.218, alpha: 1.000)
        
        //// Page-3
        //// DONT
        //// Shape-2 Drawing
        var shape2Path = UIBezierPath()
        shape2Path.moveToPoint(CGPointMake(59.39, 6.52))
        shape2Path.addLineToPoint(CGPointMake(22.42, 43.5))
        shape2Path.addCurveToPoint(CGPointMake(21.24, 43.5), controlPoint1: CGPointMake(22.09, 43.82), controlPoint2: CGPointMake(21.56, 43.82))
        shape2Path.addLineToPoint(CGPointMake(0.24, 22.5))
        shape2Path.addCurveToPoint(CGPointMake(0.24, 21.33), controlPoint1: CGPointMake(-0.08, 22.18), controlPoint2: CGPointMake(-0.08, 21.65))
        shape2Path.addLineToPoint(CGPointMake(5.35, 16.22))
        shape2Path.addCurveToPoint(CGPointMake(6.52, 16.22), controlPoint1: CGPointMake(5.67, 15.9), controlPoint2: CGPointMake(6.2, 15.9))
        shape2Path.addLineToPoint(CGPointMake(21.83, 31.53))
        shape2Path.addLineToPoint(CGPointMake(53.11, 0.24))
        shape2Path.addCurveToPoint(CGPointMake(54.29, 0.24), controlPoint1: CGPointMake(53.44, -0.08), controlPoint2: CGPointMake(53.96, -0.08))
        shape2Path.addLineToPoint(CGPointMake(59.39, 5.35))
        shape2Path.addCurveToPoint(CGPointMake(59.39, 6.52), controlPoint1: CGPointMake(59.72, 5.67), controlPoint2: CGPointMake(59.72, 6.2))
        shape2Path.addLineToPoint(CGPointMake(59.39, 6.52))
        shape2Path.closePath()
        shape2Path.miterLimit = 4;
        
        shape2Path.usesEvenOddFillRule = true;
        
        color.setFill()
        shape2Path.fill()

    }
    
    override func originalSize() -> CGSize {
        return CGSizeMake(60, 44)
    }

}

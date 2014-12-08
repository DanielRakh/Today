//
//  DRCheckmarkIcon.swift
//  Today
//
//  Created by Daniel on 11/17/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit

@IBDesignable class DRCheckmarkIconView: MMScalableVectorView {
    
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
        
        //// Shape Drawing
        var shapePath = UIBezierPath()
        shapePath.moveToPoint(CGPointMake(8, 20))
        shapePath.addLineToPoint(CGPointMake(0, 11.63))
        shapePath.addLineToPoint(CGPointMake(2.11, 9.42))
        shapePath.addLineToPoint(CGPointMake(8.06, 15.64))
        shapePath.addLineToPoint(CGPointMake(23.95, 0))
        shapePath.addLineToPoint(CGPointMake(26, 2.28))
        shapePath.addLineToPoint(CGPointMake(8, 20))
        shapePath.closePath()
        shapePath.miterLimit = 4;
        
        shapePath.usesEvenOddFillRule = true;
        
        CGContextSaveGState(context)
        shapePath.addClip()
        CGContextDrawLinearGradient(context, gradient, CGPointMake(13, 0), CGPointMake(13, 20), 0)
        CGContextRestoreGState(context)

    }
    
    override func originalSize() -> CGSize {
        return CGSizeMake(26, 20)
    }

}

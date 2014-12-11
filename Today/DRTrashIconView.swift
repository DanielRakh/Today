//
//  DRTrashIcon.swift
//  Today
//
//  Created by Daniel on 12/7/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit

@IBDesignable class DRTrashIconView: DRGradientGlyphIconView {
    
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
        
        var shapePath = UIBezierPath()
        shapePath.moveToPoint(CGPointMake(2, 23.79))
        shapePath.addCurveToPoint(CGPointMake(4.95, 27), controlPoint1: CGPointMake(2, 25.45), controlPoint2: CGPointMake(3.29, 27))
        shapePath.addLineToPoint(CGPointMake(17.95, 27))
        shapePath.addCurveToPoint(CGPointMake(21, 23.79), controlPoint1: CGPointMake(19.6, 27), controlPoint2: CGPointMake(21, 25.45))
        shapePath.addLineToPoint(CGPointMake(21, 7))
        shapePath.addLineToPoint(CGPointMake(2, 7))
        shapePath.addLineToPoint(CGPointMake(2, 23.79))
        shapePath.closePath()
        shapePath.moveToPoint(CGPointMake(20.95, 2))
        shapePath.addLineToPoint(CGPointMake(15.95, 2))
        shapePath.addCurveToPoint(CGPointMake(14.31, 0), controlPoint1: CGPointMake(15.95, 1), controlPoint2: CGPointMake(15.21, 0))
        shapePath.addLineToPoint(CGPointMake(8.58, 0))
        shapePath.addCurveToPoint(CGPointMake(6.94, 2), controlPoint1: CGPointMake(7.68, 0), controlPoint2: CGPointMake(6.94, 1))
        shapePath.addLineToPoint(CGPointMake(1.94, 2))
        shapePath.addCurveToPoint(CGPointMake(0, 3.79), controlPoint1: CGPointMake(0.84, 2), controlPoint2: CGPointMake(0, 2.69))
        shapePath.addLineToPoint(CGPointMake(0, 5))
        shapePath.addLineToPoint(CGPointMake(23, 5))
        shapePath.addLineToPoint(CGPointMake(23, 3.79))
        shapePath.addCurveToPoint(CGPointMake(20.95, 2), controlPoint1: CGPointMake(23, 2.69), controlPoint2: CGPointMake(22.05, 2))
        shapePath.closePath()
        shapePath.miterLimit = 4;
        
        shapePath.usesEvenOddFillRule = true;
        
        return shapePath
    }
    
    override func originalSize() -> CGSize {
        return CGSizeMake(23, 27)
    }

}

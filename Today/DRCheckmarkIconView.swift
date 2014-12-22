//
//  DRCheckmarkIcon.swift
//  Today
//
//  Created by Daniel on 11/17/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit

@IBDesignable class DRCheckmarkIconView: DRGradientGlyphIconView {
    
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
        gradientEndPoint = CGPointMake(0, originalSize().height)

    }
    
    func iconShape() -> UIBezierPath {
        var shapePath = UIBezierPath()
        shapePath.moveToPoint(CGPointMake(10.5, 19.78))
        shapePath.addLineToPoint(CGPointMake(2.62, 11.94))
        shapePath.addLineToPoint(CGPointMake(0, 14.55))
        shapePath.addLineToPoint(CGPointMake(10.5, 25))
        shapePath.addLineToPoint(CGPointMake(33, 2.61))
        shapePath.addLineToPoint(CGPointMake(30.38, -0))
        shapePath.addLineToPoint(CGPointMake(10.5, 19.78))
        shapePath.closePath()
        shapePath.miterLimit = 4;
        
        shapePath.usesEvenOddFillRule = true;
        
        return shapePath
    }
 
    override func originalSize() -> CGSize {
        return CGSizeMake(33, 25)
    }

}

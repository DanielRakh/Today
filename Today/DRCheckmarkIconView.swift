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
        iconMode = .On
        todayMode = .Do
        shapePath = iconShape()
        gradientEndPoint = CGPointMake(0, originalSize().height)

    }
    
    func iconShape() -> UIBezierPath {
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
        
        return shapePath
    }
 
    override func originalSize() -> CGSize {
        return CGSizeMake(26, 20)
    }

}

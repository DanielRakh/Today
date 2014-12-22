//
//  DRCloseIconView.swift
//  Today
//
//  Created by Daniel on 12/19/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit

@IBDesignable class DRCloseIconView: DRGradientGlyphIconView {
    

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
        shapePath.moveToPoint(CGPointMake(25, 2.5))
        shapePath.addLineToPoint(CGPointMake(22.5, 0))
        shapePath.addLineToPoint(CGPointMake(12.5, 10))
        shapePath.addLineToPoint(CGPointMake(2.5, 0))
        shapePath.addLineToPoint(CGPointMake(0, 2.5))
        shapePath.addLineToPoint(CGPointMake(10, 12.5))
        shapePath.addLineToPoint(CGPointMake(0, 22.5))
        shapePath.addLineToPoint(CGPointMake(2.5, 25))
        shapePath.addLineToPoint(CGPointMake(12.5, 15))
        shapePath.addLineToPoint(CGPointMake(22.5, 25))
        shapePath.addLineToPoint(CGPointMake(25, 22.5))
        shapePath.addLineToPoint(CGPointMake(15, 12.5))
        shapePath.addLineToPoint(CGPointMake(25, 2.5))
        shapePath.closePath()
        shapePath.miterLimit = 4;
        
        shapePath.usesEvenOddFillRule = true;
        
        return shapePath
    }
 
    override func originalSize() -> CGSize {
        return CGSizeMake(25, 25)
    }

}

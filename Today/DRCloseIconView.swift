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
        iconMode = .On
        todayMode = .Dont
        shapePath = iconShape()
        gradientEndPoint = CGPointMake(0, originalSize().height)
    }
    
    func iconShape() -> UIBezierPath {
        var rectangle23Path = UIBezierPath()
        rectangle23Path.moveToPoint(CGPointMake(22.91, 25))
        rectangle23Path.addLineToPoint(CGPointMake(0, 45.45))
        rectangle23Path.addLineToPoint(CGPointMake(5.09, 50))
        rectangle23Path.addLineToPoint(CGPointMake(28, 29.55))
        rectangle23Path.addLineToPoint(CGPointMake(50.91, 50))
        rectangle23Path.addLineToPoint(CGPointMake(56, 45.45))
        rectangle23Path.addLineToPoint(CGPointMake(33.09, 25))
        rectangle23Path.addLineToPoint(CGPointMake(56, 4.55))
        rectangle23Path.addLineToPoint(CGPointMake(50.91, 0))
        rectangle23Path.addLineToPoint(CGPointMake(28, 20.45))
        rectangle23Path.addLineToPoint(CGPointMake(5.09, 0))
        rectangle23Path.addLineToPoint(CGPointMake(0, 4.55))
        rectangle23Path.addLineToPoint(CGPointMake(22.91, 25))
        rectangle23Path.closePath()
        rectangle23Path.miterLimit = 4;
        
        rectangle23Path.usesEvenOddFillRule = true;
        
        return rectangle23Path
    }
 
    override func originalSize() -> CGSize {
        return CGSizeMake(56, 50)
    }

}

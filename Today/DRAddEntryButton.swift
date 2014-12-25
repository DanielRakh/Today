//
//  AddEntryButton.swift
//  Today
//
//  Created by Daniel on 11/4/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit
import QuartzCore

@IBDesignable class DRAddEntryButton: DRGradientButton {
    
    var additionGlyph:CALayer!
    
    var mode:TodayMode = .Do {
        didSet {
            UIView.animateWithDuration(0.35,
                delay: 0,
                options: .CurveEaseInOut,
                animations: { () -> Void in
                    self.applyGradientColorsForMode(self.mode)
                }, completion: { (stop:Bool) -> Void in
            })
        }
    }
    
    @IBInspectable var glyphSizeAsPercentageOfSuperView:CGFloat = 0
    
    @IBInspectable var glyphColor:UIColor = UIColor.todayOffWhite()
    
    @IBInspectable var cornerRadius:CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }

    func setup() {
        additionGlyph = createAdditionGlyph()
        layer.addSublayer(additionGlyph)
        applyGradientColorsForMode(.Do)
        
    }
    //MARK:
    //MARK: Addition Glyph Drawing
    
    enum LineType {
        case Horizontal
        case Vertical
    }
    
    func createAdditionGlyph() -> CALayer {
        let lineLength:CGFloat = self.bounds.size.width * glyphSizeAsPercentageOfSuperView
        
        let horizontalLine = lineShapeForPath(bezierPathForLine(
            lineType: .Horizontal, length: lineLength))
        let verticalLine = lineShapeForPath(bezierPathForLine(
            lineType: .Vertical, length: lineLength))
        let additionGlyphLayer = CALayer()
        
        additionGlyphLayer.bounds = CGRectMake(0, 0, CGRectGetWidth(horizontalLine.bounds), CGRectGetHeight(horizontalLine.bounds))
        additionGlyphLayer.anchorPoint = CGPointMake(0.5, 0.5)
        additionGlyphLayer.position = CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds)/2)
        
        horizontalLine.anchorPoint = CGPointMake(0.5, 0.5)
        horizontalLine.position = CGPointMake(CGRectGetWidth(additionGlyphLayer.bounds)/2, CGRectGetHeight(additionGlyphLayer.bounds)/2)
       
        verticalLine.anchorPoint = CGPointMake(0.5, 0.5)
        verticalLine.position = CGPointMake(CGRectGetWidth(additionGlyphLayer.bounds)/2, CGRectGetHeight(additionGlyphLayer.bounds)/2)
        
        additionGlyphLayer.addSublayer(horizontalLine)
        additionGlyphLayer.addSublayer(verticalLine)
        
        return additionGlyphLayer
    }
    
    func lineShapeForPath(path:UIBezierPath) -> CAShapeLayer {
        
        let shape = CAShapeLayer()
        shape.path = path.CGPath
        shape.bounds = CGRectMake(0, 0, path.bounds.size.width, path.bounds.size.height)
        shape.lineWidth = 2.0
        shape.strokeColor = glyphColor.CGColor
        return shape
    }
    
    func bezierPathForLine(#lineType:LineType, length:CGFloat) -> UIBezierPath {
        let lineBezier = UIBezierPath()
        var endPoint:CGPoint!
        switch lineType {
            case .Horizontal:
                endPoint = CGPointMake(length, 0)
            case .Vertical:
                endPoint = CGPointMake(0, length)
            default:
                endPoint = CGPointZero
        }
        lineBezier.moveToPoint(CGPointZero)
        lineBezier.addLineToPoint(endPoint)
        return lineBezier
    }
    
}





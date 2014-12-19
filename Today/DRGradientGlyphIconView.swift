//
//  DRGradientGlyphView.swift
//  Today
//
//  Created by Daniel on 12/7/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit

class DRGradientGlyphIconView: MMScalableVectorView {
    
    var todayMode:TodayMode!
    var iconMode:IconMode!
    var shapePath:UIBezierPath
    
    private var gradient:CGGradient?
    private var gradientColorArray:[CGColor]?
    private var fillColor:UIColor?
    
    override init(frame: CGRect) {
        self.shapePath = UIBezierPath()
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        self.shapePath = UIBezierPath()
        super.init(coder: aDecoder)
        setup()
        
    }
    
    private func setup() {
        backgroundColor = UIColor.clearColor()
    }
    
    override func drawInCurrentContext() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Color Declarations
        
        if let gradientColors = iconMode.colorsForTodayMode(todayMode) {
            gradientColorArray = [gradientColors.startColor.CGColor, gradientColors.endColor.CGColor]
            gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), gradientColorArray!, [0, 1])!
        } else {
            fillColor = UIColor.todayOffGray()
        }
        
        //// Shape Drawing
        
        if gradient != nil {
            CGContextSaveGState(context)
            shapePath.addClip()
            CGContextDrawLinearGradient(context, gradient, CGPointMake(11.5, -0), CGPointMake(11.5, 27), 0)
            CGContextRestoreGState(context)
        } else {
            fillColor!.setFill()
            shapePath.fill()
        }
    }
}

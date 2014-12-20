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
    var gradientEndPoint:CGPoint!
    
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
        addLongPressGesture()
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
            CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), gradientEndPoint, 0)
            CGContextRestoreGState(context)
        } else {
            fillColor!.setFill()
            shapePath.fill()
        }
    }
    
    func addLongPressGesture() {
        let longPress = UILongPressGestureRecognizer(target: self, action: "didLongPress:")
        longPress.minimumPressDuration = 0.25
        addGestureRecognizer(longPress)
    }
    
    
    func didLongPress(recognizer:UILongPressGestureRecognizer) {
        switch recognizer.state {
        case .Began:
            recognizer.view?.pop_spring().pop_scaleXY = CGPointMake(1.8, 1.8)
        case .Ended, .Cancelled:
            recognizer.view?.pop_spring().pop_scaleXY = CGPointMake(1, 1)

        default:
            println("Default recognizer state")
        }
        println("Did Long Press")
    }
    
}


extension DRGradientGlyphIconView:UIGestureRecognizerDelegate {
    
}

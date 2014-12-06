//
//  UIColor+ColorPalette.swift
//  Today
//
//  Created by Daniel on 10/21/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit


//MARK:
//MARK: Flat Colors
extension UIColor {
    
    // Gradient Colors
    class func todayGradientRedStart() -> UIColor {
        return UIColor(red:0.992, green:0.263 , blue:0.314, alpha: 1.0)
    }
    
    class func todayGradientRedEnd() -> UIColor {
        return UIColor(red:0.992, green:0.192 , blue:0.373, alpha: 1.0)
    }
    
    class func todayGradientGreenStart() -> UIColor {
        return UIColor(red:0.286, green:0.831 , blue:0.486, alpha: 1.0)
    }
    
    class func todayGradientGreenEnd() -> UIColor {
        return UIColor(red:0.231, green:0.800 , blue:0.620, alpha: 1.0)
    }
    
    // Dark Mode Colors
    class func todayDarkViewBackground() -> UIColor {
        return UIColor(red: 0.073, green: 0.073, blue: 0.078, alpha: 1.0) }
    
    class func todayDarkWatermelonRed() -> UIColor {
        return UIColor(red:0.974 , green: 0.000, blue: 0.223, alpha: 1.0) }
    
    class func todayDarkKiwiGreen() -> UIColor {
        return UIColor(red:0.432 , green: 0.812, blue: 0.105, alpha: 1.0) }
    
    class func todayDarkCellBackground() -> UIColor {
        return UIColor(white: 0.208, alpha: 1.000) }
    
    class func todayDarkCellText() -> UIColor {
        return UIColor(white: 1.0, alpha: 1.000) }
    
    class func todayDarkNavBarUnselectedText() -> UIColor {
        return UIColor(red:0.246, green:0.246 , blue:0.246, alpha: 1.0)
    }
    
    // Light Mode Colors
    class func todayLightViewBackground() -> UIColor {
        return UIColor(red:0.976, green:0.976 , blue:0.976, alpha: 1.0) }
    
    class func todayLightOrange() -> UIColor {
        return UIColor(red:0.922, green:0.337 , blue:0.208, alpha: 1.0) }
    
    class func todayLightBlue() -> UIColor {
        return UIColor(red: 0.061, green: 0.479, blue: 0.887, alpha: 1.0) }
    
    class func todayLightCellBackground() -> UIColor {
        return UIColor(red:0.996, green:0.996 , blue:0.996, alpha: 1.0) }
    
    class func todayLightCellText() -> UIColor {
        return UIColor(red:0.200, green:0.200 , blue:0.208, alpha: 1.0) }
    
    class func todayLightNavBarUnselectedText() -> UIColor {
        return UIColor(red:0.753, green:0.753 , blue:0.757, alpha: 1.0) }

    class func todayLightBorderColor() -> UIColor {
        return UIColor(red:0.847, green:0.847 , blue:0.847, alpha: 1.0) }
    
    // Optional Colors
    class func todayPastyWhite() -> UIColor {
        return UIColor(red: 0.975, green: 0.988, blue: 0.987, alpha: 1.0) }
    
    class func todayVignelliBlue() -> UIColor {
        return UIColor(red: 0.061, green: 0.479, blue: 0.887, alpha: 1.0) }
    
    class func todayVignelliRed() -> UIColor {
        return UIColor(red: 0.925, green: 0.225, blue: 0.112, alpha: 1.0) }

}

//MARK:
//MARK: Gradients
// Gradient Functions
extension CAGradientLayer {
    
    class func electricRed() -> CAGradientLayer {
        return CAGradientLayer.gradientLayerForColors(UIColor.todayGradientRedStart(), endColor: UIColor.todayGradientRedEnd())
    }
    
    class func frogGreen() -> CAGradientLayer {
        return CAGradientLayer.gradientLayerForColors(UIColor.todayGradientGreenStart(), endColor: UIColor.todayGradientGreenEnd())
    }
    
    private class func gradientLayerForColors(startColor:UIColor, endColor:UIColor) -> CAGradientLayer {
        let colors = [startColor.CGColor, endColor.CGColor] as [AnyObject]!
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.locations = [0.0, 1.0]
        return gradientLayer
    }
}




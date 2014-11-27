//
//  UIColor+ColorPalette.swift
//  Today
//
//  Created by Daniel on 10/21/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit

extension UIColor {
    
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
        return UIColor(red: 0.146, green: 0.146, blue: 0.151, alpha: 1.000)
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

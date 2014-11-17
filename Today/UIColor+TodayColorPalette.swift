//
//  UIColor+ColorPalette.swift
//  Today
//
//  Created by Daniel on 10/21/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit

extension UIColor {
    
    // Main Colors
    class func todayBackgroundBlack() -> UIColor {
        return UIColor(red: 0.073, green: 0.073, blue: 0.078, alpha: 1.0) }
    
    class func todayWatermelonRed() -> UIColor {
        return UIColor(red:0.974 , green: 0.000, blue: 0.223, alpha: 1.0) }
    
    class func todayKiwiGreen() -> UIColor {
        return UIColor(red:0.432 , green: 0.812, blue: 0.105, alpha: 1.0) }
    
    class func todayCellBackground() -> UIColor {
        return UIColor(white: 0.208, alpha: 1.000) }
    
    class func todayCellText() -> UIColor {
        return UIColor(white: 1.0, alpha: 1.000) }
    
    class func todayTabBarUnselectedText() -> UIColor {
        return UIColor(red: 0.146, green: 0.146, blue: 0.151, alpha: 1.000)
    }
    
    // Optional Colors
    class func todayPastyWhite() -> UIColor {
        return UIColor(red: 0.975, green: 0.988, blue: 0.987, alpha: 1.0) }
    
    class func todayVignelliBlue() -> UIColor {
        return UIColor(red: 0.061, green: 0.479, blue: 0.887, alpha: 1.0) }
    
    class func todayVignelliRed() -> UIColor {
        return UIColor(red: 0.925, green: 0.225, blue: 0.112, alpha: 1.0) }

}

//
//  Enums.swift
//  Today
//
//  Created by Daniel on 12/8/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import Foundation

enum TodayMode {
    
    case Dont
    case Do
    
    func gradientColors() -> (startColor:UIColor, endColor:UIColor) {
        return self == .Do ?
            (UIColor.todayGradientGreenStart(), UIColor.todayGradientGreenEnd()) :
            (UIColor.todayGradientRedStart(), UIColor.todayGradientRedEnd())
    }
}


enum IconMode {
    
    case On
    case Off
    
    func colorsForTodayMode(todayMode:TodayMode) -> (startColor:UIColor, endColor:UIColor)? {
        
        return self == .On ? todayMode.gradientColors() : nil
    }
    
    
    
    
}
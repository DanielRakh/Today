//
//  GradientButton.swift
//  Today
//
//  Created by Daniel on 12/7/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit

@IBDesignable class DRGradientButton: UIButton {

    var gradientLayer:CAGradientLayer!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    override func layoutSubviews() {
        gradientLayer.frame = self.bounds
    }
    
    private func setup() {
        addGradientLayer()
        clipsToBounds = true
    }
    
    private func addGradientLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer.locations = [0.0, 1.0]
        self.layer.insertSublayer(gradientLayer, atIndex: 0)
    }
    
    func applyGradientColorsForMode(mode:Mode) {
        
        mode == .Do ?
            applyGradientColors(UIColor.todayGradientGreenStart(), endColor: UIColor.todayGradientGreenEnd()) :
            applyGradientColors(UIColor.todayGradientRedStart(), endColor: UIColor.todayGradientRedEnd())
        
    }
    
    func applyGradientColors(startColor:UIColor, endColor:UIColor) {
        gradientLayer.colors = [startColor.CGColor, endColor.CGColor]
    }

}

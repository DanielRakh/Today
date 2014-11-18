//
//  DRBubbleBackgroundView.swift
//  Today
//
//  Created by Daniel on 11/17/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit

@IBDesignable class DRBubbleBackgroundView: UIView {
    
    @IBInspectable var cornerRadius:CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

    override func prepareForInterfaceBuilder() {
        backgroundColor = UIColor.todayCellBackground()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.todayCellBackground()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
}

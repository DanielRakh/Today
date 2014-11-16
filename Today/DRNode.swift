//
//  DRNode.swift
//  Today
//
//  Created by Daniel on 11/13/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit

class DRNode: UIView {
//    
//    override func prepareForInterfaceBuilder() {
//        backgroundColor = UIColor.todayVignelliRed()
//    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = CGRectGetWidth(self.bounds) / 2.0
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

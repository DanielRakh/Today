//
//  DRSeperatorLine.swift
//  Today
//
//  Created by Daniel on 12/3/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit

class DRSeperatorLine: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
   
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let sortaPixel = 1.0 / UIScreen.mainScreen().scale
        let topSepratorView = UIView(frame: CGRectMake(0, 0, bounds.size.width, sortaPixel))
        topSepratorView.userInteractionEnabled = false
        topSepratorView.backgroundColor = UIColor.todayOffGray()
        addSubview(topSepratorView)
        
        backgroundColor = UIColor.clearColor()
        userInteractionEnabled = false
    }
}

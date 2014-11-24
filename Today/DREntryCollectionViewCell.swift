//
//  EntryTableViewCell.swift
//  Today
//
//  Created by Daniel on 10/29/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit

@IBDesignable class DREntryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var notificationIcon: DRNotificationIconView!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    
    @IBInspectable var cornerRadius:CGFloat = 12 {
        didSet {
            layer.cornerRadius = cornerRadius
            contentView.layer.cornerRadius = cornerRadius
        }
    }
    
    var mode:Mode! = .Do {
        willSet {
            if newValue == Mode.Dont {
                lineView.backgroundColor = .todayLightBlue()
                notificationIcon.glyphColor = .todayLightBlue()

            } else {
                lineView.backgroundColor = .todayLightOrange()
                notificationIcon.glyphColor = .todayLightOrange()
            }
        }
    }
    
    override func prepareForInterfaceBuilder() {
        backgroundColor = UIColor.todayLightCellBackground()
    }
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.todayLightCellBackground()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.todayLightCellBackground()
    }
    
}

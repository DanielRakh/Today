//
//  EntryTableViewCell.swift
//  Today
//
//  Created by Daniel on 10/29/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit

class DREntryTableViewCell: UITableViewCell {

    @IBOutlet weak var notificationIcon: DRNotificationIconView!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var textView: UITextView!
    
//    @IBInspectable var cornerRadius:CGFloat = 0 {
//        didSet {
//            layer.cornerRadius = cornerRadius
//            contentView.layer.cornerRadius = cornerRadius
//        }
//    }
//
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        setupUI()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        backgroundColor = UIColor.clearColor()
        daysLabel.textColor = UIColor.todayDarkCellText()
        textView.textColor = UIColor.todayDarkCellText()
        textView.backgroundColor = UIColor.clearColor()
        lineView.backgroundColor = UIColor.todayLightBlue()
    }
    
}

//
//  EntryTableViewCell.swift
//  Today
//
//  Created by Daniel on 10/29/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit

class DREntryTableViewCell: UITableViewCell {

    @IBOutlet weak var alertOnIcon: DRAlertOnIconView!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var lineView: DRGradientView!
    @IBOutlet weak var textView: UITextView!

    
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
        daysLabel.textColor = UIColor.todayWhite()
        textView.textColor = UIColor.todayWhite()
        textView.backgroundColor = UIColor.clearColor()
        lineView.applyGradientColorsForMode(.Do)
    }
    
}

//
//  EntryTableViewCell.swift
//  Today
//
//  Created by Daniel on 10/29/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit

class DREntryTableViewCell: UITableViewCell {

    /// This is the container for Text View Mode
    @IBOutlet weak var textContainerView: UIView!
    /// These are the elements that are subviews of the container
    @IBOutlet weak var alertOnIcon: DRAlertOnIconView!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var lineView: DRGradientView!
    @IBOutlet weak var textView: UITextView!
    
    /// This is the container for Button Mode
    @IBOutlet weak var buttonContainerView: UIView!
    /// These are the elements that are subviews of the container
    @IBOutlet weak var trashButton: UIButton!
    @IBOutlet weak var trashIconView: DRTrashIconView!
    @IBOutlet weak var checkmarkButton: UIButton!
    @IBOutlet weak var checkmarkIconView: DRCheckmarkIconView!
    @IBOutlet weak var alertButton: UIButton!
    @IBOutlet weak var alertIconView: DRAlertOnIconView!
    
    
    

    
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

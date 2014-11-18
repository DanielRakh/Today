//
//  EntryTableViewCell.swift
//  Today
//
//  Created by Daniel on 10/29/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit

class DREntryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bubbleBackgroundView: DRBubbleBackgroundView!
    @IBOutlet weak var notificationIcon: DRNotificationIconView!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.clearColor()
        contentView.backgroundColor = UIColor.clearColor()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

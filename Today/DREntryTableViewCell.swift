//
//  EntryTableViewCell.swift
//  Today
//
//  Created by Daniel on 10/29/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit

class DREntryTableViewCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var bubbleBackgroundView: UIView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.clearColor()
        contentView.backgroundColor = UIColor.clearColor()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bubbleBackgroundView.backgroundColor = UIColor.todayCellBackground()
        bubbleBackgroundView.layer.cornerRadius = 12.0

        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

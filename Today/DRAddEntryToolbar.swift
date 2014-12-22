//
//  DRAddEntryToolbar.swift
//  Today
//
//  Created by Daniel on 12/19/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit

class DRAddEntryToolbar: UIView {
    
    @IBOutlet weak var closeIcon:DRCloseIconView!
    @IBOutlet weak var checkmarkIcon:DRCheckmarkIconView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.clearColor()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clearColor()
    }
    
    override func awakeFromNib() {
        setup()
    }
    
    func setup() {
        //Set initial postion of icons to a scale of (0,0)
        closeIcon.pop_scaleXY = CGPointMake(0, 0)
        closeIcon.todayMode = .Dont
        closeIcon.iconMode = .On
        checkmarkIcon.pop_scaleXY = CGPointMake(0, 0)
        checkmarkIcon.pop_spring().alpha = 0
    }
    
    func springPop(view:UIView, reveal:Bool) {
        let toScale:CGFloat = reveal == true ? 1 : 0.1
        view.pop_springBounciness = 20
        view.pop_springSpeed = 18
        view.pop_spring().alpha = 1
        view.pop_spring().pop_scaleXY = CGPointMake(toScale, toScale)
       
    }
    
}

extension DRAddEntryToolbar:DREntryTableViewCellDelegate {
    
    func textViewDidChange(textView: UITextView) {
        //
    }
}












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
        backgroundColor = UIColor.todayOffWhite()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.todayOffWhite()
    }
    
    override func awakeFromNib() {
        setup()
        
    }
    
    func setup() {
        //Set initial postion of icons to a scale of (0,0)
        closeIcon.transform = CGAffineTransformMakeScale(0.001, 0.001)
        closeIcon.todayMode = .Dont
        closeIcon.iconMode = .On
        checkmarkIcon.transform = CGAffineTransformMakeScale(0.001, 0.001)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "revealSaveButton:", name: "EntryCellTextViewIsValidToSave", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "hideSaveButton:", name: "EntryCellTextViewIsInvalidToSave", object: nil)
    }
    
    
    func revealSaveButton(notification:NSNotification) {
        checkmarkIcon.animateScaleWithSpringPOP(nil, springSpeed: nil, reveal: true)
    }
    
    func hideSaveButton(notification:NSNotification) {
        checkmarkIcon.animateScaleWithSpringPOP(nil, springSpeed: nil, reveal: false)

    }
    

}













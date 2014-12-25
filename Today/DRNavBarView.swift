//
//  DRTabBar.swift
//  Today
//
//  Created by Daniel on 11/7/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit

@objc protocol DRNavBarViewDelegate {
    optional func doButtonDidTouch(sender:AnyObject)
    optional func dontButtonDidTouch(sender:AnyObject)
}


class DRNavBarView: UIView {
    
    var entryMode:EntryMode
    var todayMode:TodayMode
    
    var delegate:DRNavBarViewDelegate?
    
    //This is the toolbar that appears when we add a new entry
    @IBOutlet weak var addEntryToolbar:DRAddEntryToolbar!
    
    // These are the view that appear when we are in normal/default mode
    @IBOutlet var normalModeCollection:[UIView]!
    @IBOutlet weak var dontButton:UIButton!
    @IBOutlet weak var doButton:UIButton!
    @IBOutlet weak var dontLabel:UILabel!
    @IBOutlet weak var doLabel:UILabel!
    @IBOutlet weak var underlineView:DRGradientView!
    
    
    //Constraints
    @IBOutlet var centerXAlignUnderlineToDoLabel:NSLayoutConstraint!
    @IBOutlet var equalWidthUnderlineToDoLabel:NSLayoutConstraint!
    var centerXAlignUnderlineToDontLabel:NSLayoutConstraint?
    var equalWidthUnderlineToDontLabel:NSLayoutConstraint?

    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    required init(coder aDecoder: NSCoder) {
        todayMode = .Do
        entryMode = .Normal
        super.init(coder: aDecoder)
        backgroundColor = UIColor.todayOffWhite()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "switchToNewMode:", name: "EntryButtonTapped", object: nil)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupInitialUI()
    }
    
    func setupInitialUI() {
        doLabel.textColor = UIColor.todayDarkText()
        dontLabel.textColor = UIColor.todayOffGray()
        underlineView.applyGradientColorsForMode(.Do)
        addEntryToolbar.hidden = true
    }
    
    //MARK: Functions
    
    override func updateConstraints() {
        if (centerXAlignUnderlineToDontLabel == nil && equalWidthUnderlineToDontLabel == nil) {
            setupDontLabelConstraints()
        }
            super.updateConstraints()
        }

    func performAnimationsForMode(mode:TodayMode, withDuration duration:NSTimeInterval) {
        
        adjustContraintsForMode(mode)
        
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping:0.7, initialSpringVelocity:0.5, options: .CurveEaseInOut, animations: {
            self.dontLabel.textColor = mode == .Do ? UIColor.todayOffGray() : UIColor.todayDarkText()
            self.doLabel.textColor = mode == .Do ? UIColor.todayDarkText() : UIColor.todayOffGray()
            self.underlineView.applyGradientColorsForMode(mode)
            self.layoutIfNeeded()
            }, completion: { finished in
                self.todayMode = mode
        })
        
    }
    
    func adjustContraintsForMode(mode:TodayMode) {
        switch mode {
        case .Do:
            removeConstraints([centerXAlignUnderlineToDontLabel!, equalWidthUnderlineToDontLabel!])
            setNeedsUpdateConstraints()
            addConstraints([centerXAlignUnderlineToDoLabel,equalWidthUnderlineToDoLabel])
        case .Dont:
            removeConstraints([centerXAlignUnderlineToDoLabel,equalWidthUnderlineToDoLabel])
            setNeedsUpdateConstraints()
            addConstraints([centerXAlignUnderlineToDontLabel!, equalWidthUnderlineToDontLabel!])
            
        default:
            println("There was an error adjusting constraints for mode")
        }
    }
 
    //MARK: Auto Layout
    
    func setupDontLabelConstraints() {
        centerXAlignUnderlineToDontLabel = NSLayoutConstraint(
            item: underlineView,
            attribute: .CenterX,
            relatedBy: .Equal,
            toItem: dontLabel,
            attribute: .CenterX,
            multiplier: 1,
            constant: 0)
        
        equalWidthUnderlineToDontLabel = NSLayoutConstraint(
            item: underlineView,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: dontLabel,
            attribute: .Width,
            multiplier: 1,
            constant: 0)
    }

    
    //MARK: IBActions
    
    @IBAction func doButtonPressed(sender:AnyObject) {
        if todayMode == .Dont {
            delegate?.doButtonDidTouch?(sender)
            performAnimationsForMode(.Do, withDuration: 0.5)
        }
    }
    
    @IBAction func dontButtonPressed(sender:AnyObject) {
        if todayMode == .Do {
            delegate?.dontButtonDidTouch?(sender)
            performAnimationsForMode(.Dont, withDuration: 0.5)
        }
    }
    
    //MARL: Notifications
    
    func switchToNewMode(notification:NSNotification) {
        
        NSObject.pop_animate({
            self.addEntryToolbar.hidden = false
            for view in self.normalModeCollection {
                view.pop_easeInEaseOut().alpha = 0
            }
            }, completion: { (success:Bool) -> Void in
                self.addEntryToolbar.closeIcon.animateScaleWithSpringPOP(nil, springSpeed: nil, reveal: true)
        })
    }
}

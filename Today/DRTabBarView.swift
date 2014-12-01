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
    optional func addEntryButtonDidTouch(sender:AnyObject)
}

public enum Mode {
    case Dont
    case Do
}

class DRNavBarView: UIView {
    
    var delegate:DRNavBarViewDelegate?
    
    @IBOutlet weak var dontButton:UIButton!
    @IBOutlet weak var doButton:UIButton!
    @IBOutlet weak var dontLabel:UILabel!
    @IBOutlet weak var doLabel:UILabel!
    @IBOutlet weak var underlineView:UIView!
    @IBOutlet weak var addEntryButton:DRAddEntryButton!
    
    @IBOutlet var centerXAlignUnderlineToDoLabel:NSLayoutConstraint!
    @IBOutlet var equalWidthUnderlineToDoLabel:NSLayoutConstraint!
    var centerXAlignUnderlineToDontLabel:NSLayoutConstraint?
    var equalWidthUnderlineToDontLabel:NSLayoutConstraint?
    
    var currentButtonSelected:Mode? {
        didSet {
            if currentButtonSelected != nil {
                adjustColorForMode(currentButtonSelected!)
            }
        }
    }
    
    //MARK: Functions
    
    override func updateConstraints() {
        if (centerXAlignUnderlineToDontLabel == nil && equalWidthUnderlineToDontLabel == nil) {
            setupDontLabelConstraints()
        }
            super.updateConstraints()
        }
    
    required init(coder aDecoder: NSCoder) {
        currentButtonSelected = .Do
        super.init(coder: aDecoder)
        
        backgroundColor = UIColor.clearColor()
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.todayLightBorderColor().CGColor
    }
    
    //MARK: Helpers
    
    func adjustColorForMode(mode:Mode) {
        dontLabel.textColor = currentButtonSelected == .Do ? UIColor.todayLightNavBarUnselectedText() : UIColor.todayLightCellText()
        doLabel.textColor = currentButtonSelected == .Do ? UIColor.todayLightCellText() : UIColor.todayLightNavBarUnselectedText()
        underlineView.backgroundColor = currentButtonSelected == .Do ? UIColor.todayLightBlue() : UIColor.todayLightOrange()
        addEntryButton.backgroundColor = currentButtonSelected == .Do ? UIColor.todayLightBlue() : UIColor.todayLightOrange()
    }
    
    
    func performUnderlineAnimationForMode(mode:Mode, withDuration duration:NSTimeInterval) {
        
        adjustContraintsForMode(mode)
        
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping:0.7, initialSpringVelocity:0.5, options: .CurveEaseInOut, animations: {
            UIView.performWithoutAnimation({ () -> Void in
                self.currentButtonSelected = mode
            })
            self.layoutIfNeeded()
            }, completion: { finished in
                //
        })
        
    }
    
    func adjustContraintsForMode(mode:Mode) {
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
        if currentButtonSelected == .Dont {
            delegate?.doButtonDidTouch?(sender)
//            performUnderlineAnimationForMode(.Do, withDuration: 0.5)
        }
    }
    
    @IBAction func dontButtonPressed(sender:AnyObject) {
        if currentButtonSelected == .Do {
            delegate?.dontButtonDidTouch?(sender)
//            performUnderlineAnimationForMode(.Dont)
        }
    }
    
    @IBAction func addEntryButtonPressed(sender: AnyObject) {
        delegate?.addEntryButtonDidTouch?(sender)
    }
    
}

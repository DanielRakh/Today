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
    
    var delegate:DRNavBarViewDelegate?
    
    @IBOutlet weak var dontButton:UIButton!
    @IBOutlet weak var doButton:UIButton!
    @IBOutlet weak var dontLabel:UILabel!
    @IBOutlet weak var doLabel:UILabel!
    @IBOutlet weak var underlineView:DRGradientView!
    
    @IBOutlet var centerXAlignUnderlineToDoLabel:NSLayoutConstraint!
    @IBOutlet var equalWidthUnderlineToDoLabel:NSLayoutConstraint!
    var centerXAlignUnderlineToDontLabel:NSLayoutConstraint?
    var equalWidthUnderlineToDontLabel:NSLayoutConstraint?
    
    var mode:Mode
    
    required init(coder aDecoder: NSCoder) {
        mode = .Do
        super.init(coder: aDecoder)
        backgroundColor = UIColor.todayDarkGray()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        doLabel.textColor = UIColor.todayWhite()
        dontLabel.textColor = UIColor.todayFadedGray()
        underlineView.applyGradientColors(mode.gradientColors().startColor, endColor: mode.gradientColors().endColor)
    }
    
    //MARK: Functions
    
    override func updateConstraints() {
        if (centerXAlignUnderlineToDontLabel == nil && equalWidthUnderlineToDontLabel == nil) {
            setupDontLabelConstraints()
        }
            super.updateConstraints()
        }

    func performAnimationsForMode(mode:Mode, withDuration duration:NSTimeInterval) {
        
        adjustContraintsForMode(mode)
        
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping:0.7, initialSpringVelocity:0.5, options: .CurveEaseInOut, animations: {
            self.dontLabel.textColor = mode == .Do ? UIColor.todayFadedGray() : UIColor.todayWhite()
            self.doLabel.textColor = mode == .Do ? UIColor.todayWhite() : UIColor.todayFadedGray()
            self.layoutIfNeeded()
            }, completion: { finished in
                self.mode = mode
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
        if mode == .Dont {
            delegate?.doButtonDidTouch?(sender)
            performAnimationsForMode(.Do, withDuration: 0.5)
        }
    }
    
    @IBAction func dontButtonPressed(sender:AnyObject) {
        if mode == .Do {
            delegate?.dontButtonDidTouch?(sender)
            performAnimationsForMode(.Dont, withDuration: 0.5)
        }
    }
    
}

//
//  DRTabBar.swift
//  Today
//
//  Created by Daniel on 11/7/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit

protocol DRTabBarViewDelegate {
    func doButtonDidTouch(sender:AnyObject)
    func dontButtonDidTouch(sender:AnyObject)
}

enum ButtonMode {
    case Dont
    case Do
}

class DRTabBarView: UIView {
    
    var delegate:DRTabBarViewDelegate?
    
    @IBOutlet weak var dontButton:UIButton!
    @IBOutlet weak var doButton:UIButton!
    
    @IBOutlet weak var dontLabel:UILabel!
    @IBOutlet weak var doLabel:UILabel!
    
    @IBOutlet weak var underlineView:UIView!
    
    @IBOutlet var centerXAlignUnderlineToDoLabel:NSLayoutConstraint!
    @IBOutlet var equalWidthUnderlineToDoLabel:NSLayoutConstraint!
    var centerXAlignUnderlineToDontLabel:NSLayoutConstraint?
    var equalWidthUnderlineToDontLabel:NSLayoutConstraint?
    
    var currentButtonSelected:ButtonMode? {
        didSet {
            if currentButtonSelected != nil {
                dontLabel.textColor = currentButtonSelected == .Do ? UIColor.todayTextGray() : UIColor.todayPastyWhite()
                doLabel.textColor = currentButtonSelected == .Do ? UIColor.todayPastyWhite() : UIColor.todayTextGray()
                
            }
        }
    }
    
    override func updateConstraints() {
        if (centerXAlignUnderlineToDontLabel == nil && equalWidthUnderlineToDontLabel == nil) {
            setupDontLabelConstraints()
        }
            super.updateConstraints()
        }
    
    required init(coder aDecoder: NSCoder) {
        currentButtonSelected = .Do
        super.init(coder: aDecoder)
    }
 
    //MARK: Helpers
    
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
    
    
    func performUnderlineAnimationForMode(mode:ButtonMode) {
        
        adjustContraintsForMode(mode)
    
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping:0.7, initialSpringVelocity:1.0, options: .CurveEaseInOut, animations: {
            UIView.performWithoutAnimation({ () -> Void in
                self.currentButtonSelected = mode
            })
                self.layoutIfNeeded()
            }, completion: { finished in
                //
        })
        
    }
    
    func adjustContraintsForMode(mode:ButtonMode) {
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
    
    //MARK: IBActions
    
    @IBAction func doButtonPressed(sender:AnyObject) {
        if currentButtonSelected == .Dont {
            delegate?.doButtonDidTouch(sender)
            performUnderlineAnimationForMode(.Do)
        }
    }
    
    @IBAction func dontButtonPressed(sender:AnyObject) {
        
        if currentButtonSelected == .Do {
            delegate?.dontButtonDidTouch(sender)
            performUnderlineAnimationForMode(.Dont)
        }
    }
    
}
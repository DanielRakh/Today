//
//  EntryTableViewCell.swift
//  Today
//
//  Created by Daniel on 10/29/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit

class DREntryTableViewCell: UITableViewCell, POPAnimationDelegate {

    /// This is the container for Text View Mode
    @IBOutlet weak var textContainerView: UIView!
    /// These are the elements that are subviews of the container
    @IBOutlet weak var alertOnIcon: DRAlertOnIconView!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var lineView: DRGradientView!
    @IBOutlet weak var textView: UITextView!
    
    /// This is the container for Button Mode
    @IBOutlet weak var buttonContainerView: UIView!
    @IBOutlet var iconArray: [DRGradientGlyphIconView]!
    /// These are the elements that are subviews of the container
    @IBOutlet weak var trashButton: UIButton!
    @IBOutlet weak var trashIconView: DRTrashIconView!
    @IBOutlet weak var checkmarkButton: UIButton!
    @IBOutlet weak var checkmarkIconView: DRCheckmarkIconView!
    @IBOutlet weak var alertButton: UIButton!
    @IBOutlet weak var alertIconView: DRAlertOnIconView!
    
    
    lazy var tapGesture = UITapGestureRecognizer()
    
    
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
        setupForMode(.Do)
        
        addGestureRecognizer(tapGesture)
        tapGesture.addTarget(self, action:"didTap:")
        
        for icon in iconArray {
            icon.alpha = 0
            icon.pop_spring().pop_scaleXY = CGPointMake(0.1, 0.1)
        }
        
    }
    
    func setupForMode(mode:TodayMode) {
        lineView.applyGradientColorsForMode(mode)

    }
    
    func didTap(recoginzer:UITapGestureRecognizer) {
        slideOutView(textContainerView)
    }
    
    func slideOutView(view:UIView) {
        
        
        
//        let decayAnimation = POPSpringAnimation(propertyNamed: kPOPViewCenter)
//        decayAnimation.toValue = NSValue(CGPoint: CGPointMake(-view.bounds.size.width/2 , view.center.y))
//        decayAnimation.delegate = self
//        view.layer.pop_addAnimation(decayAnimation, forKey: "TextViewSpringFrame")
        
        let springAlpha = POPSpringAnimation(propertyNamed: kPOPViewAlpha)
        springAlpha.toValue = NSNumber(float: 0)
        springAlpha.delegate = self
        view.pop_addAnimation(springAlpha, forKey: "TextViewSpringAlpha")
        
    }
    

    
    func pop_animationDidReachToValue(anim: POPAnimation!) {
//        if (anim.name as NSString).isEqualToString("TextViewSpringFrame") {
            (self.iconArray.reverse() as NSArray).pop_sequenceWithInterval(0.15, animations: { (object:AnyObject!, index:Int) -> Void in
                if object is DRGradientGlyphIconView {
                    let icon = object as DRGradientGlyphIconView
                    icon.pop_springBounciness = 20
                    icon.pop_springSpeed = 18
                    icon.pop_spring().alpha = 1
                    icon.pop_spring().pop_scaleXY = CGPointMake(1, 1)
                }
                }) { (finished:Bool) -> Void in
                    //
            }
        }
//    }
    
    
}

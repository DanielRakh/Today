//
//  DRTabBar.swift
//  Today
//
//  Created by Daniel on 11/7/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit

protocol DRTabBarDelegate {
    func doButtonDidTouch(sender:AnyObject)
    func dontButtonDidTouch(sender:AnyObject)
}


class DRTabBar: UIView {
    
    var delegate:DRTabBarDelegate?

    @IBOutlet weak var dontButton:UIButton!
    @IBOutlet weak var doButton:UIButton!
    
    
    //MARK: IBActions
    
    @IBAction func doButtonPressed(sender:AnyObject) {
        println("Do Button Pressed")
        delegate?.doButtonDidTouch(sender)
    }
    
    @IBAction func dontButtonPressed(sender:AnyObject) {
        println("Dont Button Pressed")
        delegate?.dontButtonDidTouch(sender)
    }
}

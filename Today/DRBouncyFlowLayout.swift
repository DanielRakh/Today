//
//  DRBouncyFlowLayout.swift
//  Today
//
//  Created by Daniel on 12/2/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit

class DRBouncyFlowLayout: UICollectionViewFlowLayout {
    
    private var animator:UIDynamicAnimator!
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        animator = UIDynamicAnimator(collectionViewLayout: self)
        
    }
    
    override init() {
        super.init()
        animator = UIDynamicAnimator(collectionViewLayout: self)
    }
    
    override func collectionViewContentSize() -> CGSize {
        return super.collectionViewContentSize()
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
//        if animator
        return animator.itemsInRect(rect)
        
        
    }
}
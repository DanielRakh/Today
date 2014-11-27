//
//  DRSpringyFlowLayout.swift
//  Today
//
//  Created by Daniel on 11/24/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit

class DRSpringyFlowLayout: UICollectionViewFlowLayout {
    
    let kScrollResistanceFactor:CGFloat = 900.0
    var scrollResistanceFactor:CGFloat?
    var dynamicAnimator:UIDynamicAnimator!
    var latestDelta:CGFloat = 0
    var visibleIndexPathsSet:NSMutableSet = NSMutableSet()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        dynamicAnimator = UIDynamicAnimator(collectionViewLayout: self)

    }
    
    override init() {
        super.init()
        dynamicAnimator = UIDynamicAnimator(collectionViewLayout: self)
    }
    
    
    override func prepareLayout() {
        super.prepareLayout()
        
        let contentSize = collectionViewContentSize()
        let visibleRect = CGRectInset(CGRectMake(collectionView!.bounds.origin.x, collectionView!.bounds.origin.y, contentSize.width, contentSize.height), -100, -100)
        
        let itemsInVisibleRectArray = super.layoutAttributesForElementsInRect(visibleRect) as NSArray!
        let itemsIndexPathsInVisibleRectSet = NSSet(array:(itemsInVisibleRectArray.valueForKey("indexPath") as NSArray))

        
        for item in dynamicAnimator.behaviors {
            if item.isKindOfClass(UIAttachmentBehavior) {
                let springBehavior = item as UIAttachmentBehavior
                let layoutAttributesItem = springBehavior.items.first as UICollectionViewLayoutAttributes!
                for attributes in itemsInVisibleRectArray {
                    if attributes.isKindOfClass(UICollectionViewLayoutAttributes) {
                        if attributes.indexPath == layoutAttributesItem.indexPath {
                            if itemsInVisibleRectArray.count != dynamicAnimator.behaviors.count {
                                layoutAttributesItem.frame = attributes.frame
                                dynamicAnimator.updateItemUsingCurrentState(layoutAttributesItem)
                            }
                            springBehavior.anchorPoint = attributes.center
                        }
                    }
                }
            }
        }
        
        
        
        //Remove any behaviors that are no longer visible
        let noLongerVisibleBehaviors = (dynamicAnimator.behaviors as NSArray).filteredArrayUsingPredicate(NSPredicate {
            (someObject:AnyObject?, bindings:Dictionary?) -> Bool in
            if someObject!.isKindOfClass(UIAttachmentBehavior) {
                let behavior = someObject as UIAttachmentBehavior
                return itemsIndexPathsInVisibleRectSet.containsObject(behavior.items.first!.indexPath!) == false
            }
            return false
            })

        
        for item in noLongerVisibleBehaviors  {
            if item.isKindOfClass(UIAttachmentBehavior) {
                let behavior = item as UIAttachmentBehavior
                dynamicAnimator.removeBehavior(behavior)
                visibleIndexPathsSet.removeObject(behavior.items.first!)
            }
        }
        
        //Add any newly visible visible behaviors.
        // A "newly visible" item is one that is in the itemsInVisibleRect(Set|Array) but not in the visibleIndexPathsSet
        
        let newlyVisibleItems = itemsInVisibleRectArray.filteredArrayUsingPredicate(NSPredicate { (someObject:AnyObject!, bindings:Dictionary?) -> Bool in
            if someObject.isKindOfClass(UICollectionViewLayoutAttributes) {
                let item = someObject as UICollectionViewLayoutAttributes
                return self.visibleIndexPathsSet.containsObject(item.indexPath) == false
            }
            return false
            })
        
        let touchLocation = collectionView?.panGestureRecognizer.locationInView(collectionView)
        
        for (index, item) in enumerate(newlyVisibleItems) {
            let layoutAttributesItem = item as UICollectionViewLayoutAttributes
            var center = layoutAttributesItem.center
            let springBehavior = UIAttachmentBehavior(item: layoutAttributesItem, attachedToAnchor: layoutAttributesItem.center)
            
            springBehavior.length = 1.0
            springBehavior.damping = 0.8
            springBehavior.frequency = 1.0
            
            // If our touchLocation is not (0,0), we'll need to adjust our item's center "in flight"
            if !(CGPointEqualToPoint(CGPointZero, touchLocation!)) {
                if scrollDirection == .Vertical {
                    let distanceFromTouch = fabs(touchLocation!.y - springBehavior.anchorPoint.y)
                    
                    var scrollResistance:CGFloat
                    if scrollResistanceFactor != nil {
                        scrollResistance = distanceFromTouch / scrollResistanceFactor!
                    } else {
                        scrollResistance = distanceFromTouch /  kScrollResistanceFactor
                    }
                    
                    if latestDelta < 0 {
                        center.y += max(latestDelta, latestDelta * scrollResistance)
                    } else {
                        center.y += min(latestDelta, latestDelta * scrollResistance)
                    }
                    
                    layoutAttributesItem.center = center
                    
                } else {
                    
                    let distanceFromTouch = fabs(touchLocation!.x - springBehavior.anchorPoint.x)
                    var scrollResistance:CGFloat
                    
                    if scrollResistanceFactor != nil {
                        scrollResistance = distanceFromTouch / scrollResistanceFactor!
                    } else {
                        scrollResistance = distanceFromTouch /  kScrollResistanceFactor
                    }
                    
                    if latestDelta < 0 {
                        center.x += max(latestDelta, latestDelta * scrollResistance)
                    } else {
                        center.x += min(latestDelta, latestDelta * scrollResistance)
                    }
                    
                    layoutAttributesItem.center = center
                    
                }
            }
            
            dynamicAnimator.addBehavior(springBehavior)
            visibleIndexPathsSet.addObject(layoutAttributesItem.indexPath)
        }
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        return dynamicAnimator.itemsInRect(rect)
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
        let dynamicLayoutAttributes = dynamicAnimator.layoutAttributesForCellAtIndexPath(indexPath)
        return dynamicLayoutAttributes != nil ? dynamicLayoutAttributes : super.layoutAttributesForItemAtIndexPath(indexPath)
    }
    
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        
        let scrollView = collectionView as UIScrollView!
        var delta:CGFloat = newBounds.origin.y - scrollView.bounds.origin.y
        latestDelta = delta
        let touchLocation = collectionView!.panGestureRecognizer.locationInView(collectionView)
        
        for (_, item) in enumerate(dynamicAnimator.behaviors) {
            if item.isKindOfClass(UIAttachmentBehavior) {
                let springBehavior = item as UIAttachmentBehavior
                let distanceFromTouch:CGFloat = fabs(touchLocation.y - springBehavior.anchorPoint.y)
                var scrollResistance:CGFloat
                if scrollResistanceFactor != nil {
                    scrollResistance = distanceFromTouch / scrollResistanceFactor!
                } else {
                    scrollResistance = distanceFromTouch / kScrollResistanceFactor
                }
                
                let item = springBehavior.items.first as UICollectionViewLayoutAttributes
                var center = item.center
                if delta < 0 {
                    center.y += max(delta, delta * scrollResistance)
                } else {
                    center.y += min(delta, delta * scrollResistance)
                }
                item.center = center
                dynamicAnimator.updateItemUsingCurrentState(item)
            }
        }
        
        return false
        
    }
    
    
    override func prepareForCollectionViewUpdates(updateItems: [AnyObject]!) {
        super.prepareForCollectionViewUpdates(updateItems)
        
        for (idx, item) in enumerate(updateItems) {
            let updateItem = item as UICollectionViewUpdateItem
            
            if updateItem.updateAction == .Insert {
                if (dynamicAnimator.layoutAttributesForCellAtIndexPath(updateItem.indexPathAfterUpdate) != nil) {
                    return;
                }
                
                let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: updateItem.indexPathAfterUpdate)
                
                let springBehavior = UIAttachmentBehavior(item: attributes, attachedToAnchor: attributes.center)
                
                springBehavior.length = 1.0
                springBehavior.damping = 0.8
                springBehavior.frequency = 1.0
                dynamicAnimator.addBehavior(springBehavior)
            }
        }
    }
}

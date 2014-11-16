//
//  DRCalanderTimelineView.swift
//  Today
//
//  Created by Daniel on 11/13/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit

enum Mode {
    case Expanded
    case Compressed
}

class DRProgressView: UIView {
    
    @IBOutlet weak var backgroundView:UIView!
    
    var progressView:UIView!
    
//    let nodes:[DRNode] = {
//        var nodeArray = [DRNode]()
//        for _ in 1...7 {
//            nodeArray += [DRNode(frame: CGRectMake(0, 0, 23, 23))]
//        }
//        return nodeArray
//        
//        }()

    var mode:Mode! {
        didSet {
            if mode != nil {
                //Animate the expansion of the nodes based on mode set
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let tap = UITapGestureRecognizer(target: self, action: "didTap")
        addGestureRecognizer(tap)
    }
    
    func setup() {
        
        //Setup Progress View
        progressView = UIView()
        progressView.backgroundColor = UIColor.todayVignelliBlue()
        backgroundView.addSubview(progressView)
        
        //Add Nodes
//        for node in nodes {
//            progressView.addSubview(node)
//        }
        
        
    }
    
    func layout() {
        progressView.frame = CGRectMake(0, 0, backgroundView.bounds.size.width * 0.25, backgroundView.bounds.size.height)
        
//        for (index, node) in enumerate(nodes) {
//            node.frame.origin = CGPointMake(25.0 * CGFloat(index), 0)
//        }

        
    }
    
    func didTap() {
        UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseInOut, animations: { () -> Void in
            self.progressView.frame.size.width = self.backgroundView.frame.size.width
            }) { (success:Bool) -> Void in
                //
        }
    }
    
}

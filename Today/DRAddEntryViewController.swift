//
//  DRAddEntryViewController.swift
//  Today
//
//  Created by Daniel on 12/11/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit

class DRAddEntryViewController: UIViewController {
    
    let characterLimit:Int = 80
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var characterCountLabel: UILabel!
    var todayMode:TodayMode!
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    func setup() {
        view.backgroundColor = UIColor.todayDarkGray()
        textView.textColor = UIColor.todayWhite()
        characterCountLabel.textColor = UIColor.todayWhite()
        characterCountLabel.text = String(characterLimit)
        textView.delegate = self
        textView.becomeFirstResponder()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    //MARK:
    //MARK: HELPERS
    
    func updateCharacterCountLabelForText(text:String) {
        characterCountLabel.text = "\((text as NSString).length)" + "/\(characterLimit)"
    }

    @IBAction func dismissButtonTapped(sender: AnyObject) {
        textView.resignFirstResponder()
        
        DREntryService.sharedInstance.saveEntry(textView.text, type: todayMode)
        presentingViewController?.dismissViewControllerAnimated(true, completion: { () -> Void in
            //
        })
    }
}

extension DRAddEntryViewController : UITextViewDelegate {
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        updateLabel(characterCountLabel, forRange: range, replacementText: text)

        return true
    }
    
    func updateLabel(characterCountLabel:UILabel, forRange range:NSRange, replacementText text:String) {
        
        let characterCountLabelLength = characterCountLabel.text!.toInt()!
       
        if range.length >= 1 {
            characterCountLabel.text = "\(characterCountLabelLength + range.length)"
        } else {
            let replacementStringLength = (text as NSString).length
            characterCountLabel.text = "\(characterCountLabelLength - replacementStringLength)"
        }
        
        characterCountLabel.textColor = characterCountLabel.text?.toInt() <= 5 ? UIColor.todayGradientRedStart() : UIColor.todayWhite()
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
//        updateCharacterCountLabelForText(textView.text)

    }
    
}

//
//  DoViewController.swift
//  Today
//
//  Created by Daniel on 10/29/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit


class DoViewController: UIViewController {

    @IBOutlet weak var tableView: EntryTableView!

//    var tableViewDataSource:TableViewManager
    
//    required init(coder aDecoder: NSCoder) {
//        tableViewDataSource = TableViewManager(tableView: self.tableView, withCellIdentifier: "DoCell")
//        super.init(coder: aDecoder)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tableViewManager = TableViewManager(tableView: self.tableView, withCellIdentifier: "DoCell")
          tableView.dataSource = tableViewManager
//        self.tableView.backgroundColor = UIColor.todayWhite
//        self.tableView.tableFooterView = UIView(frame: CGRectZero)
//        self.tableView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0)
        
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//extension DoViewController: UITableViewDataSource {
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return activities.count
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("DoCell") as ActivityTableViewCell
//        return cell
//    }
//}


//extension DoViewController: UITextFieldDelegate {
//    
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        
//        textField.resignFirstResponder()
//        return true
//    }
//}




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

    var tableViewDataSource:TableViewManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewDataSource = TableViewManager(tableView: self.tableView, items:nil, withCellIdentifier: "DoCell")
          tableView.dataSource = tableViewDataSource
    
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


//extension DoViewController: UITextFieldDelegate {
//    
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        
//        textField.resignFirstResponder()
//        return true
//    }
//}




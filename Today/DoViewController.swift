//
//  DoViewController.swift
//  Today
//
//  Created by Daniel on 10/29/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit


class DoViewController: UIViewController, MasterViewControllerDelegate {

    @IBOutlet weak var tableView: EntryTableView!

    var tableViewManager:DoTableViewManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        tableViewManager = DoTableViewManager(tableView: self.tableView, items:[1,2,3], withCellIdentifier: "DoCell")
    }
}


extension DoViewController: MasterViewControllerDelegate {
    func addEntryButtonDidTap() {
        tableViewManager.insertRow()
    }
}

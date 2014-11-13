//
//  DoViewController.swift
//  Today
//
//  Created by Daniel on 10/29/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit


class DRDoViewController: UIViewController, DRMasterViewControllerDelegate {

    @IBOutlet weak var tableView: DREntryTableView!

    var tableViewManager:DRDoTableViewManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        tableViewManager = DRDoTableViewManager(tableView: self.tableView, items:[1,2,3], withCellIdentifier: "DoCell")
    }
}


extension DRDoViewController: DRMasterViewControllerDelegate {
    func addEntryButtonDidTap() {
        tableViewManager.insertRow()
    }
}

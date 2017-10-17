//
//  ViewController.swift
//  Populator
//
//  Created by Manuel Meyer on 03.12.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import UIKit


class TableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var datasource: ViewControllerDataSource<UITableView>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.datasource = ViewControllerDataSource(with: tableView)
        self.datasource?.intSelected = {
            [weak self] int, indexPath in
            guard let `self` = self else { return }
            print("\(int) @ \(indexPath) @ \(String(describing: self.tableView.cellForRow(at: indexPath)))")
        }
        self.datasource?.stringSelected = {
            [weak self] str, indexPath in
            guard let `self` = self else { return }
            print("\(str) @ \(indexPath) @ \(String(describing: self.tableView.cellForRow(at: indexPath)))")
        }
    }
}

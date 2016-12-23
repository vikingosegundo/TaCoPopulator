//
//  MockViewController.swift
//  TaCoPopulator
//
//  Created by Manuel Meyer on 23.12.16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import TaCoPopulator

class MockViewController<View: PopulatorView>: UIViewController {

    var datasource: MockDataSource<View>?
    var populatorView: PopulatorView? {
        didSet{
            if let populatorView = populatorView {
                if let tableView = populatorView as? UITableView {
                    self.view.addSubview(tableView)
                } else if let collectionView = populatorView as? UICollectionView {
                    self.view.addSubview(collectionView)
                }
                
                datasource = MockDataSource<View>(with: populatorView)
            }
        }
    }
}

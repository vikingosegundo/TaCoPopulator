//
//  CollectionViewController.swift
//  Populator
//
//  Created by Manuel Meyer on 07.12.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import UIKit


class CollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private var datasource: ViewControllerDataSource<UICollectionView>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.datasource = ViewControllerDataSource(with: collectionView)
        self.datasource?.intSelected = {
            [weak self] int, indexPath in
            guard let `self` = self else { return }
            print("\(int) @ \(indexPath) @ \(String(describing: self.collectionView.cellForItem(at: indexPath)))")
        }
        self.datasource?.stringSelected = {
            [weak self] str, indexPath in
            guard let `self` = self else { return }
            print("\(str) @ \(indexPath) @ \(String(describing: self.collectionView.cellForItem(at: indexPath)))")
        }
    }
}

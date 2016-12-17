//
//  PopulatorView.swift
//  Populator
//
//  Created by Manuel Meyer on 09.12.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import UIKit

public
protocol PopulatorView: class {
    func reload()
}

extension UITableView: PopulatorView {
    public func reload() {
        self.reloadData()
    }
}

extension UICollectionView: PopulatorView {
    public func reload() {
        self.reloadData()
    }
}

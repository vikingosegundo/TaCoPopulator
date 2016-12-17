//
//  IntegerTableViewCell.swift
//  Populator
//
//  Created by Manuel Meyer on 07.12.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import UIKit


class IntegerTableViewCell: UITableViewCell {

    var theInt: Int?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let theInt = theInt {
            self.textLabel?.text = "\(theInt)"
        }
    }
}

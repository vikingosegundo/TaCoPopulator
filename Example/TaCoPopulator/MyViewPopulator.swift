//
//  TableViewPopulator+CellDisapear.swift
//  Populator
//
//  Created by Manuel Meyer on 09.12.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import Foundation
import TaCoPopulator


class MyViewPopulator : ViewPopulator {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("will display")
        let f = sectionCellModelsFactories[indexPath.section]
        let element = f.provider.objectAt(indexPath.row)
        print(element)
    }
}

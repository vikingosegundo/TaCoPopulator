//
//  CollectionViewControllerDataSource.swift
//  Populator
//
//  Created by Manuel Meyer on 07.12.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import TaCoPopulator


class ViewControllerDataSource<TableOrCollectionView: PopulatorView> {
    init(with populatorView: PopulatorView) {
        self.populatorView = populatorView
        setup()
    }
    
    var intSelected: ((Int, IndexPath) -> Void)?
    var stringSelected: ((String, IndexPath) -> Void)?
    
    let dp1 = IntDataProvider {
        _ in return "Cell"
    }
    
    let dp2 = StringDataProvider {
        _ in return "Cell"
    }
    
    
    weak var populatorView: PopulatorView?
    var populator: Populator<MyViewPopulator>?
    
    func setup(){
        dp1.selected = {
            [weak self] element, indexPath in
            self?.intSelected?(element, indexPath)
        }
        
        dp2.selected = {
            [weak self] element, indexPath in
            self?.stringSelected?(element, indexPath)
        }
        
        let collectionViewCellConfig: (Any, TextCollectionViewCell, IndexPath) -> TextCollectionViewCell  = {
            element, cell, _ in
            cell.textLabel?.text = "\(element)"
            return cell
        }
        
        let tableViewViewCellConfig: (Any, UITableViewCell, IndexPath) -> UITableViewCell  = {
            element, cell, _ in
            cell.textLabel?.text = "\(element)"
            return cell
        }
        
        if  let populatorView  = populatorView as? UICollectionView {
            let  section1factory = SectionCellsFactory<Int, TextCollectionViewCell>(populatorView: populatorView, provider: dp1, cellConfigurator: collectionViewCellConfig)
            let  section2factory = SectionCellsFactory<String, TextCollectionViewCell>(populatorView: populatorView, provider: dp2, cellConfigurator: collectionViewCellConfig)
            
            let elementsDidReload = section1factory.elementsDidReload
            section1factory.elementsDidReload = {
                print("did reload")
                elementsDidReload?()
            }
            
            self.populator = Populator(with: populatorView, sectionCellModelsFactories: [section1factory, section2factory])
        }
        
        if  let populatorView  = populatorView as? UITableView {
            let section1factory = SectionCellsFactory<Int, UITableViewCell>(populatorView: populatorView, provider: dp1, cellConfigurator: tableViewViewCellConfig)
            let section2factory = SectionCellsFactory<String, UITableViewCell>(populatorView: populatorView, provider: dp2, cellConfigurator: tableViewViewCellConfig)
            self.populator = Populator(with: populatorView, sectionCellModelsFactories: [section1factory, section2factory])

            dp1.heightForCell = {
                elm, indexPath in
                return CGFloat(5 * indexPath.row + 44)
            }
        }
    }

}

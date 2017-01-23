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
    
    let dp2 = StringDataProvider  {
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
        
        let intCollectionViewCellConfig: (CellConfigurationDescriptor<Int, TextCollectionViewCell>) -> TextCollectionViewCell  = {
            configuration in
            configuration.cell.textLabel?.text = "\(configuration.element)"
            return configuration.cell
        }
        let stringCollectionViewCellConfig: (CellConfigurationDescriptor<String, TextCollectionViewCell>) -> TextCollectionViewCell  = {
            configuration in
            configuration.cell.textLabel?.text = "\(configuration.element)"
            return configuration.cell
        }
        
        let intTableViewViewCellConf: (CellConfigurationDescriptor<Int, UITableViewCell>) -> UITableViewCell  = {
            configuration in
            configuration.cell.textLabel?.text = "\(configuration.element)"
            return configuration.cell
        }
        
        let stringTableViewViewCellConf: (CellConfigurationDescriptor<String, UITableViewCell>) -> UITableViewCell  = {
            configuration in
            configuration.cell.textLabel?.text = "\(configuration.element)"
            return configuration.cell
        }
        
        if  let populatorView  = populatorView as? UICollectionView {
            let  section1factory = SectionCellsFactory<Int, TextCollectionViewCell>(populatorView: populatorView, provider: dp1, cellConfigurator: intCollectionViewCellConfig)
            let  section2factory = SectionCellsFactory<String, TextCollectionViewCell>(populatorView: populatorView, provider: dp2, cellConfigurator: stringCollectionViewCellConfig)
            
            let elementsDidReload = section1factory.elementsDidReload
            section1factory.elementsDidReload = {
                print("did reload")
                elementsDidReload?()
            }
            
            self.populator = Populator(with: populatorView, sectionCellModelsFactories: [section1factory, section2factory])
        }
        
        if  let populatorView  = populatorView as? UITableView {
            let section1factory = SectionCellsFactory<Int, UITableViewCell>(populatorView: populatorView, provider: dp1, cellConfigurator: intTableViewViewCellConf)
            let section2factory = SectionCellsFactory<String, UITableViewCell>(populatorView: populatorView, provider: dp2, cellConfigurator: stringTableViewViewCellConf)
            self.populator = Populator(with: populatorView, sectionCellModelsFactories: [section1factory, section2factory])

            dp1.heightForCell = {
                elm, indexPath in
                return CGFloat(5 * indexPath.row + 44)
            }
            
            dp2.header = {
                let view = UITableViewHeaderFooterView(frame: CGRect(x: 0, y: 0, width: 100, height: 200))
                view.contentView.backgroundColor = .yellow
                return view
            }
            
            dp2.footer = {
                let view = UITableViewHeaderFooterView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
                view.contentView.backgroundColor = .cyan
                return view
            }
            
        }
    }

}

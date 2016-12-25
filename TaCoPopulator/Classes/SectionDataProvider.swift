//
//  SectionDataProvider.swift
//  Populator
//
//  Created by Manuel Meyer on 08.12.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import Foundation


public
protocol SectionDataProviderType {
    var didSelectIndexPath:((IndexPath) -> Void)? { get }
    var elementsDidReload:(() -> Void)? { set get }
    func numberOfElements() -> Int
    func elementAt(index: Int) -> Any
    func heightForIndexPath(_ indexPath: IndexPath) -> CGFloat
}


open
class SectionDataProvider<Element>: SectionDataProviderType {
    
    public
    init(reuseIdentifer: @escaping (Element, IndexPath) -> String) {
        self.reuseIdentifer = reuseIdentifer
    }
    
    open
    var elementsDidReload: (() -> Void)?

    open fileprivate(set)
    var didSelectIndexPath:((IndexPath) -> Void)?
    
    open
    var selected:((Element, IndexPath) -> Void)? {
        didSet {
            didSelectIndexPath = {
                [weak self] indexPath in
                guard let `self` = self else { return }
                let element = self.elements()[indexPath.row]
                self.selected?(element,indexPath)
            }
        }
    }
    
    fileprivate
    var privateElements: [Element] = [] {
        didSet{
            elementsDidReload?()
        }
    }
    
    internal
    let reuseIdentifer: (Element, IndexPath) -> String
    
    public
    var heightForCell:((Element, IndexPath) -> CGFloat)?
    
    public
    func heightForIndexPath(_ indexPath: IndexPath) -> CGFloat {
        if let heightForCell = heightForCell, let elm = elementAt(index: indexPath.row) as? Element {
            return heightForCell(elm, indexPath)
        }
        return UITableViewAutomaticDimension
    }
}

extension SectionDataProvider {
    
    open
    func provideElements(_ elements: [Element]) {
        privateElements = elements
    }
    
    open
    func elementAt(index:Int) -> Any {
        return elements()[index]
    }
    
    open
    func elements() -> [Element] {
        return privateElements
    }
    
    open
    func numberOfElements() -> Int {
        return elements().count
    }
}

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
    func objectAt(index: Int) -> Any
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
}

extension SectionDataProvider {
    
    open
    func provideElements(_ elements: [Element]) {
        privateElements = elements
    }
    
    open
    func objectAt(index:Int) -> Any {
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

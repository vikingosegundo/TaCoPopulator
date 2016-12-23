//
//  MockDataProviders.swift
//  TaCoPopulator
//
//  Created by Manuel Meyer on 23.12.16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import TaCoPopulator

class MockIntDataProvider: SectionDataProvider<Int> {
    
    override init(reuseIdentifer: @escaping (Int, IndexPath) -> String) {
        super.init(reuseIdentifer: reuseIdentifer)
        self.provideElements([1,2,3,4,5,6,7,8,9])
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
            self.provideElements(self.elements() + [10, 11, 12, 13, 14, 15])
        }
    }
}


class MockStringDataProvider: SectionDataProvider<String> {
    override init(reuseIdentifer: @escaping (String, IndexPath) -> String) {
        super.init(reuseIdentifer: reuseIdentifer)
        self.provideElements(["Hallo","Welt", "!"])
    }
}


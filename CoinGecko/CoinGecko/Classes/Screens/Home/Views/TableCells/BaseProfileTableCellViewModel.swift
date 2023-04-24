//
//  BaseProfileTableCellViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 24.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

class BaseProfileTableCellViewModel {
    var selectClosure: Closure.Void?
    
    init(selectClosure: Closure.Void? = nil) {
        self.selectClosure = selectClosure
    }
}

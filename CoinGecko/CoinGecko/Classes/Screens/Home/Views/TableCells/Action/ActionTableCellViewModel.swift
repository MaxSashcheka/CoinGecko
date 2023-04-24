//
//  ActionTableCellViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 24.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import Utils

extension HomeViewController.ActionTableCell {
    final class ViewModel: BaseProfileTableCellViewModel {
        let title = CurrentValueSubject<String, Never>(.empty)
        
        init(title: String,
             selectClosure: Closure.Void? = nil) {
            self.title.send(title)
            
            super.init(selectClosure: selectClosure)
        }
    }
}

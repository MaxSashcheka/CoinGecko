//
//  ProfileTableCellViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 24.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import Utils

extension HomeViewController.ProfileTableCell {
    final class ViewModel: BaseProfileTableCellViewModel {
        enum CellType {
            case common, action
        }
        
        let title = CurrentValueSubject<String, Never>(.empty)
        let description = CurrentValueSubject<String, Never>(.empty)
        let isSeparatorLineHidden = CurrentValueSubject<Bool, Never>(false)
        let type = CurrentValueSubject<CellType, Never>(.common)
        
        init(title: String,
             description: String,
             isSeparatorLineHidden: Bool = false,
             type: CellType = .common,
             selectClosure: Closure.Void? = nil) {
            self.title.send(title)
            self.description.send(description)
            self.isSeparatorLineHidden.send(isSeparatorLineHidden)
            self.type.send(type)
            
            super.init(selectClosure: selectClosure)
        }
    }
}

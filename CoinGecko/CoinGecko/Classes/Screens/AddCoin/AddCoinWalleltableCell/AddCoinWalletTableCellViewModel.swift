//
//  AddCoinWallelTableCellViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 28.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import Foundation

extension AddCoinWalletTableCell {
    final class ViewModel {
        let id: UUID
        let title = CurrentValueSubject<String, Never>(.empty)
        let isSelected = CurrentValueSubject<Bool, Never>(false)
        
        init(id: UUID, title: String, isSelected: Bool = false) {
            self.id = id
            self.title.send(title)
            self.isSelected.send(isSelected)
        }
    }
}

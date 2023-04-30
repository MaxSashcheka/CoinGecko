//
//  WalletTableCellViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 27.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import UIKit.UIColor

extension WalletTableCell {
    final class ViewModel {
        let id: UUID
        let walletViewModel = WalletView.ViewModel()
        
        init(id: UUID, title: String, coinsCount: Int = .zero, color: UIColor) {
            self.id = id
            self.walletViewModel.title.send(title)
            self.walletViewModel.coinsCount.send(coinsCount)
            self.walletViewModel.color.send(color)
        }
    }
}

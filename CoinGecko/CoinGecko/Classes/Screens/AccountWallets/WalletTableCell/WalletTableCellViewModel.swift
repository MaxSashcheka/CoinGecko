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
        let walletViewModel = WalletView.ViewModel()
        
        init(title: String, color: UIColor) {
            self.walletViewModel.title.send(title)
            self.walletViewModel.color.send(color)
        }
    }
}

//
//  WalletViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 27.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import UIKit.UIColor

extension WalletView {
    final class ViewModel {
        let title = CurrentValueSubject<String, Never>(.empty)
        let coinsCount = CurrentValueSubject<Int, Never>(.zero)
        let color = CurrentValueSubject<UIColor, Never>(.clear)
        
        init(title: String = .empty, coinsCount: Int = .zero, color: UIColor = .clear) {
            self.title.send(title)
            self.coinsCount.send(coinsCount)
            self.color.send(color)
        }
    }
}

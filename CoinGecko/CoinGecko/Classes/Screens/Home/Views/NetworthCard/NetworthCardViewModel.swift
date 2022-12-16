//
//  NetworthCardViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 29.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import Foundation

extension HomeViewController.NetworhCardView {
    final class ViewModel {
        let networthValue = CurrentValueSubject<String, Never>(.empty)
        let dayProfitTitle = CurrentValueSubject<String, Never>(.empty)
        let dayProfitValue = CurrentValueSubject<String, Never>(.empty)
        
        init(networthValue: String = .empty,
             dayProfitTitle: String = .empty,
             dayProfitValue: String = .empty) {
            self.networthValue.send(networthValue)
            self.dayProfitTitle.send(dayProfitTitle)
            self.dayProfitValue.send(dayProfitValue)
        }
    }
}

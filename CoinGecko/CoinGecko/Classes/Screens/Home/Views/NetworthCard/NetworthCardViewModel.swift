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
        let networth = CurrentValueSubject<Double, Never>(.zero)
        let dayProfit = CurrentValueSubject<Double, Never>(.zero)
        
        init(networth: Double = .zero,
             dayProfit: Double = .zero) {
            self.networth.send(networth)
            self.dayProfit.send(dayProfit)
        }
    }
}

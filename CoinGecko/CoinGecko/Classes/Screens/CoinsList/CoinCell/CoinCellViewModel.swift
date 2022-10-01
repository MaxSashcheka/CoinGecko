//
//  CoinCellViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 16.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Core
import RxCocoa
import RxSwift

extension CoinsListViewController.CoinCell {
    typealias TitledDescriptionViewModel = TitledDescriptionView.ViewModel
    
    final class ViewModel {
        let id: String
        let imageURL: URL?
        let nameTitledDescriptionViewModel: TitledDescriptionViewModel
        let priceInfoTitledDescriptionViewModel: TitledDescriptionViewModel
        let isPriceChangePositive: Bool
        let coin: Coin
        
        init(id: String,
             imageURL: URL?,
             name: String = .empty,
             symbol: String = .empty,
             currentPrice: String = .empty,
             priceChangePercentage: String = .empty,
             isPriceChangePositive: Bool,
             coin: Coin) {
            self.id = id
            self.imageURL = imageURL
            self.isPriceChangePositive = isPriceChangePositive
            self.coin = coin
            
            nameTitledDescriptionViewModel = TitledDescriptionViewModel(
                titleText: name,
                descriptionText: symbol
            )
            priceInfoTitledDescriptionViewModel = TitledDescriptionViewModel(
                titleText: currentPrice.description,
                descriptionText: priceChangePercentage
            )
        }
    }
}

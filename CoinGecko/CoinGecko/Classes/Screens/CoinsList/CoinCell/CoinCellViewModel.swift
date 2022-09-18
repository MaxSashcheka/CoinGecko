//
//  CoinCellViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 16.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

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
        
        init(id: String,
             imageURL: URL?,
             name: String = .empty,
             symbol: String = .empty,
             currentPrice: String = .empty,
             priceChangePercentage: String = .empty,
             isPriceChangePositive: Bool) {
            self.id = id
            self.imageURL = imageURL
            self.isPriceChangePositive = isPriceChangePositive
            
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

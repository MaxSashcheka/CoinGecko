//
//  NetworthCoinCellViewModel.swift
//  CoinGecko
//
//  Created by Max Sashcheka on 30.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import Core

extension NetworthCoinCell {
    typealias TitledDescriptionViewModel = TitledDescriptionView.ViewModel
    
    final class ViewModel {
        let id: String
        let imageURL: URL?
        let nameTitledDescriptionViewModel: TitledDescriptionViewModel
        let priceInfoTitledDescriptionViewModel: TitledDescriptionViewModel
        let networthTitledDescriptionViewModel: TitledDescriptionViewModel
        let isPriceChangePositive: Bool
        
        init(id: String,
             imageURL: URL?,
             name: String = .empty,
             symbol: String = .empty,
             currentPrice: String = .empty,
             priceChangePercentage: String = .empty,
             isPriceChangePositive: Bool = false,
             portfolioCount: Double,
             portfolioPrice: Double ) {
            self.id = id
            self.imageURL = imageURL
            self.isPriceChangePositive = isPriceChangePositive
            
            self.nameTitledDescriptionViewModel = TitledDescriptionViewModel(
                titleText: name,
                descriptionText: symbol
            )
            self.priceInfoTitledDescriptionViewModel = TitledDescriptionViewModel(
                titleText: currentPrice.description,
                descriptionText: priceChangePercentage
            )
            
            self.networthTitledDescriptionViewModel = TitledDescriptionViewModel(
                titleText: "Portfolio count: \(portfolioCount)",
                descriptionText: "Portfolio networth: \(portfolioPrice)"
            )
        }
    }
}


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
    typealias Texts = L10n.Home.Portfolio.Title
    
    final class ViewModel {
        let id: String
        let nameTitledDescriptionViewModel: TitledDescriptionViewModel
        let priceInfoTitledDescriptionViewModel: TitledDescriptionViewModel
        let networthTitledDescriptionViewModel: TitledDescriptionViewModel
        let imageURL = CurrentValueSubject<URL?, Never>(nil)
        let isPriceChangePositive = CurrentValueSubject<Bool, Never>(true)
        
        var deleteSubject = PassthroughSubject<String, Never>()
        
        init(id: String,
             imageURL: URL?,
             name: String = .empty,
             symbol: String = .empty,
             currentPrice: String = .empty,
             priceChangePercentage: String = .empty,
             isPriceChangePositive: Bool = false,
             portfolioCount: Double,
             portfolioPrice: String ) {
            self.id = id
            self.imageURL.send(imageURL)
            self.isPriceChangePositive.send(isPriceChangePositive)
            
            self.nameTitledDescriptionViewModel = TitledDescriptionViewModel(
                titleText: name,
                descriptionText: symbol
            )
            self.priceInfoTitledDescriptionViewModel = TitledDescriptionViewModel(
                titleText: currentPrice.description,
                descriptionText: priceChangePercentage
            )
            
            self.networthTitledDescriptionViewModel = TitledDescriptionViewModel(
                titleText: Texts.count(portfolioCount),
                descriptionText: Texts.networth(portfolioPrice)
            )
        }
    }
}

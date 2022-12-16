//
//  CoinCellViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 16.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import Core

extension CoinCell {
    typealias TitledDescriptionViewModel = TitledDescriptionView.ViewModel
    
    final class ViewModel {
        let id: String
        let nameTitledDescriptionViewModel: TitledDescriptionViewModel
        let priceInfoTitledDescriptionViewModel: TitledDescriptionViewModel
        let imageURL = CurrentValueSubject<URL?, Never>(nil)
        let isPriceChangePositive = CurrentValueSubject<Bool, Never>(true)
        
        init(id: String,
             imageURL: URL?,
             name: String = .empty,
             symbol: String = .empty,
             currentPrice: String = .empty,
             priceChangePercentage: String = .empty,
             isPriceChangePositive: Bool = false) {
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
        }
    }
}

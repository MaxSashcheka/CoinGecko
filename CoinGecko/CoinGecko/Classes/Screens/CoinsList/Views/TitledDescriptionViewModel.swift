//
//  TitledDescriptionViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 17.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Foundation

extension TitledDescriptionView {
    final class ViewModel {
        let titleText: String
        let descriptionText: String
        
        init(titleText: String = .empty,
             descriptionText: String = .empty) {
            self.titleText = titleText
            self.descriptionText = descriptionText
        }
    }
}

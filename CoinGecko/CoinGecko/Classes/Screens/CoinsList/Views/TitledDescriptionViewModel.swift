//
//  TitledDescriptionViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 17.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine

extension TitledDescriptionView {
    final class ViewModel {
        let titleText = CurrentValueSubject<String, Never>(.empty)
        let descriptionText = CurrentValueSubject<String, Never>(.empty)
        
        init(titleText: String = .empty,
             descriptionText: String = .empty) {
            self.titleText.send(titleText)
            self.descriptionText.send(descriptionText)
        }
    }
}

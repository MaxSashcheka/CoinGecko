//
//  PostTableCellViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 23.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import Core

extension PostTableCell {
    final class ViewModel {
        let imageURL = CurrentValueSubject<URL?, Never>(nil)
        let title = CurrentValueSubject<String, Never>(.empty)
        
        init(imageURL: URL?, title: String) {
            self.imageURL.send(imageURL)
            self.title.send(title)
        }
    }
}

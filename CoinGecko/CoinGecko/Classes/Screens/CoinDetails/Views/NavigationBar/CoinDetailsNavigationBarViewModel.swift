//
//  CoinDetailsNavigationBarViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 18.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import Foundation

extension CoinDetailsViewController.CoinDetailsNavigationBarView {
    class ViewModel {
        let title = CurrentValueSubject<String, Never>(.empty)
        let description = CurrentValueSubject<String, Never>(.empty)
        let imageURL = CurrentValueSubject<URL?, Never>(nil)
        let closeButtonSubject = PassthroughSubject<Void, Never>()
        
        init(title: String = .empty,
             description: String = .empty,
             imageURL: URL? = nil) {
            self.title.send(title)
            self.description.send(description)
            self.imageURL.send(imageURL)
        }
    }
}

//
//  CoinDetailsNavigationBarViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 18.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import RxCocoa
import RxSwift

extension CoinDetailsViewController.CoinDetailsNavigationBarView {
    class ViewModel {
        let title = BehaviorRelay<String>(value: .empty)
        let imageURL = BehaviorRelay<URL?>(value: nil)
        let closeButtonRelay = BehaviorRelay<Void>(value: ())
        
        init(title: String = .empty, imageURL: URL? = nil) {
            self.title.accept(title)
            self.imageURL.accept(imageURL)
        }
    }
}

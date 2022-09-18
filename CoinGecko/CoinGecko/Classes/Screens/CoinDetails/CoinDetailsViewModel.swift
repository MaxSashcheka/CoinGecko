//
//  CoinDetailsViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 18.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Core
import RxCocoa
import RxSwift
import Utils

extension CoinDetailsViewController {
    final class ViewModel {
        private let coinsInteractor: CoinsInteractorProtocol
        
        var closeTransition: Closure.Void?
        
        let navigationBarViewModel = CoinDetailsNavigationBarView.ViewModel()
        
        let imageURL = BehaviorRelay<URL?>(value: nil)
        let descriptionText = BehaviorRelay<String>(value: .empty)
        
        init(coinId: String, coinsInteractor: CoinsInteractorProtocol) {
//            self.coinId = coinId
            self.coinsInteractor = coinsInteractor
            
            coinsInteractor.getCoinDetailInfo(id: coinId, success: { [weak self] coinDetails in
                guard let self = self else { return }
                
                self.navigationBarViewModel.title.accept(coinDetails.name)
                self.navigationBarViewModel.imageURL.accept(coinDetails.image.smallURL)
                
                self.imageURL.accept(coinDetails.image.largeURL)
                self.descriptionText.accept(coinDetails.description.descriptionText)
                
            }, failure: { error in
                print(error)
            })
        }
        
        func didTapCloseButton() {
            closeTransition?()
        }
    }
}

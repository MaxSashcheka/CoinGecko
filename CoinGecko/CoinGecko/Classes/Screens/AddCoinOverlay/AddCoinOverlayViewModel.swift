//
//  AddCoinOverlayViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 31.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Core
import Utils

extension AddCoinOverlayViewController {
    final class ViewModel {
        private let coinsInteractor: CoinsInteractorProtocol
        
        var closeTransition: Closure.Void?
        
        init(coinsInteractor: CoinsInteractorProtocol) {
            self.coinsInteractor = coinsInteractor
            
//            let coin = Coin(coinResponse: Coinre)
        }
        
        func didTriggerCloseAction() {
            closeTransition?()
        }
    }
}

//(lldb) po coinsInteractor.coinsCacheDataManager
//<CoinsCacheDataManager: 0x281b9a280>
//
//(lldb) po coinsInteractor
//<CoinsInteractor: 0x283fa14a0>

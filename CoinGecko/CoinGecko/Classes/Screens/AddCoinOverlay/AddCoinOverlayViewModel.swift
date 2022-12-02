//
//  AddCoinOverlayViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 31.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import Core
import Utils

extension AddCoinOverlayViewController {
    final class ViewModel: ErrorHandableViewModel {
        private let coinId: String
        private let coinsInteractor: CoinsInteractorProtocol
        
        let amountText = CurrentValueSubject<String, Never>(.empty)
        let incorrectNumberSubject = PassthroughSubject<Void, Never>()
        
        private let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.decimalSeparator = String.comma
            return formatter
        }()
        
        var closeTransition: Closure.Void?
        
        init(coinId: String,
             coinsInteractor: CoinsInteractorProtocol) {
            self.coinId = coinId
            self.coinsInteractor = coinsInteractor
            
            super.init()
        }
    }
}

// MARK: - AddCoinOverlayViewController.ViewModel+FillData
extension AddCoinOverlayViewController.ViewModel {
    func fillAmountInfoIfPossible() {
        coinsInteractor.getStoredCoin(withId: coinId, success: { [weak self] coin in
            guard let coin = coin,
                  let amount = coin.amount,
                  amount != .zero else { return }
            self?.amountText.send(amount.description.replacingOccurrences(of: String.dot, with: String.comma))
        }, failure: errorHandlerClosure)
    }
}

// MARK: - AddCoinOverlayViewController.ViewModel+TapActions
extension AddCoinOverlayViewController.ViewModel {
    func didTriggerCloseAction() {
        closeTransition?()
    }

    func didTapAddButton(amountText: String) {
        guard let amount = formatter.number(from: amountText)?.doubleValue,
              amount != .zero else {
            incorrectNumberSubject.send(())
            return
        }

        coinsInteractor.getStoredCoin(withId: coinId, success: { [weak self] coin in
            guard let self = self else { return }
            guard var coin = coin else {
                self.closeTransition?()
                return
            }
            coin.amount = amount
            self.coinsInteractor.createOrUpdate(coin: coin, success: { [weak self] in
                self?.closeTransition?()
            }, failure: self.errorHandlerClosure)
        }, failure: errorHandlerClosure)
    }
}

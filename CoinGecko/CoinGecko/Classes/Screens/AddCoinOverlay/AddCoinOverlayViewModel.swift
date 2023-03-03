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
    final class ViewModel: ErrorHandableViewModel, ScreenTransitionable {
        private let services: Services
        let transitions: Transitions
        
        private let coinId: String
        
        let amountText = CurrentValueSubject<String, Never>(.empty)
        let incorrectNumberSubject = PassthroughSubject<Void, Never>()
        
        private let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.decimalSeparator = String.comma
            return formatter
        }()
        
        init(transitions: Transitions,
             services: Services,
             coinId: String) {
            self.transitions = transitions
            self.services = services
            self.coinId = coinId
        }
    }
}

// MARK: - AddCoinOverlayViewViewModel+NestedTypes
extension AddCoinOverlayViewController.ViewModel {
    struct Transitions: ScreenTransitions {
        let close: Transition
    }
    
    final class Services {
        let coins: CoinsServiceProtocol
        
        init(coins: CoinsServiceProtocol) {
            self.coins = coins
        }
    }
}

// MARK: - AddCoinOverlayViewController.ViewModel+FillData
extension AddCoinOverlayViewController.ViewModel {
    func fillAmountInfoIfPossible() {
        services.coins.getStoredCoin(withId: coinId, success: { [weak self] coin in
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
        transitions.close()
    }

    func didTapAddButton(amountText: String) {
        guard let amount = formatter.number(from: amountText)?.doubleValue,
              amount != .zero else {
            incorrectNumberSubject.send(())
            return
        }

        services.coins.getStoredCoin(withId: coinId, success: { [weak self] coin in
            guard let self = self else { return }
            guard var coin = coin else {
                self.transitions.close()
                return
            }
            coin.amount = amount
            self.services.coins.createOrUpdate(coin: coin, success: { [weak self] in
                self?.transitions.close()
            }, failure: self.errorHandlerClosure)
        }, failure: errorHandlerClosure)
    }
}

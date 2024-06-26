//
//  ComposeWalletViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 26.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import Core
import UIKit.UIColor
import Utils

extension ComposeWalletViewController {
    final class ViewModel: ScreenTransitionable, HandlersAccessible {
        private typealias Texts = L10n.ComposeWallet.Name
        
        private let services: Services
        let transitions: Transitions
        
        let walletViewModel = WalletView.ViewModel(color: Assets.Colors.red.color)
        
        let nameTitledTextFieldViewModel = TitledTextField.ViewModel(
            title: Texts.title,
            errorHintText: Texts.hint
        )
        
        init(transitions: Transitions, services: Services) {
            self.services = services
            self.transitions = transitions
            
            nameTitledTextFieldViewModel.saveTextClosure = { [weak self] in
                self?.walletViewModel.title.send($0)
            }
        }
    }
}

// MARK: - ComposeWalletViewModel+NestedTypes
extension ComposeWalletViewController.ViewModel {
    struct Transitions: ScreenTransitions {
        let close: Transition
        let completion: Transition
        let pickColor: (@escaping Closure.UIColor) -> Void
    }
    
    final class Services {
        let wallets: WalletsServiceProtocol
        
        init(wallets: WalletsServiceProtocol) {
            self.wallets = wallets
        }
    }
}

extension ComposeWalletViewController.ViewModel {
    func didTapCloseButton() {
        transitions.close()
    }
    
    func didTapPickColorButton() {
        transitions.pickColor { [weak self] in
            self?.walletViewModel.color.send($0)
        }
    }
    
    func didTapFinishButton() {
        nameTitledTextFieldViewModel.isErrorVisible.send(false)
        if nameTitledTextFieldViewModel.text.value.isEmpty {
            nameTitledTextFieldViewModel.isErrorVisible.send(true)
        }
        
        guard let colorHex = walletViewModel.color.value.hexValue,
              !nameTitledTextFieldViewModel.isErrorVisible.value else { return }
        
        activityIndicator.show()
        services.wallets.createWallet(
            name: nameTitledTextFieldViewModel.text.value,
            colorHex: colorHex,
            completion: { [weak self] result in
                switch result {
                case .success(_):
                    self?.activityIndicator.hide()
                    self?.transitions.completion()
                case .failure(let error):
                    self?.errorsHandler.handle(error: error, completion: self?.activityIndicator.hideClosure)
                }
            }
        )
    }
}

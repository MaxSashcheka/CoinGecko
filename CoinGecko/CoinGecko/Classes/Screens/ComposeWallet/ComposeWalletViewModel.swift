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
    final class ViewModel: ErrorHandableViewModel, ScreenTransitionable {
        private let services: Services
        let transitions: Transitions
        
        let walletTitle = CurrentValueSubject<String, Never>(.empty)
        let walletColor = CurrentValueSubject<UIColor, Never>(Assets.Colors.red.color)
        
        let nameTitledTextFieldViewModel = TitledTextField.ViewModel(
            title: "Write wallet title",
            errorHintText: "Wallet title should not be empty"
        )
        
        init(transitions: Transitions, services: Services) {
            self.services = services
            self.transitions = transitions
            
            super.init()
            
            nameTitledTextFieldViewModel.saveTextClosure = { [weak self] in
                self?.walletTitle.send($0)
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
            self?.walletColor.send($0)
        }
    }
    
    func didTapFinishButton() {
        nameTitledTextFieldViewModel.isErrorVisible.send(false)
        if nameTitledTextFieldViewModel.text.value.isEmpty {
            nameTitledTextFieldViewModel.isErrorVisible.send(true)
        }
        
        guard let colorHex = walletColor.value.hexValue,
              !nameTitledTextFieldViewModel.isErrorVisible.value else { return }
        
        ActivityIndicator.show()
        services.wallets.createWallet(
            name: nameTitledTextFieldViewModel.text.value,
            colorHex: colorHex,
            success: { [weak self] in
                ActivityIndicator.hide()
                self?.transitions.completion()
            },
            failure: { [weak self] in
                ActivityIndicator.hide()
                self?.errorHandlerClosure?($0)
            }
        )
    }
}

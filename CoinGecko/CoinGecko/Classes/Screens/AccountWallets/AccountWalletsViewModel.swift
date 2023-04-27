//
//  AccountWalletsViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 26.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import Core
import Utils
import UIKit.UIColor

extension AccountWalletsViewController {
    final class ViewModel: ErrorHandableViewModel, ScreenTransitionable {
        private let services: Services
        let transitions: Transitions
        
        let walletsViewModels = CurrentValueSubject<[WalletTableCell.ViewModel], Never>([])
        
        init(transitions: Transitions, services: Services) {
            self.services = services
            self.transitions = transitions
            
            super.init()
            
            fetchWallets()
        }
    }
}

// MARK: - AccountWalletsViewModel+NestedTypes
extension AccountWalletsViewController.ViewModel {
    struct Transitions: ScreenTransitions {
        var composeWallet: (@escaping Closure.Void) -> Void
    }
    
    final class Services {
        let wallets: WalletsServiceProtocol
        
        init(wallets: WalletsServiceProtocol) {
            self.wallets = wallets
        }
    }
}

// MARK: - AccountWalletsViewModel+TableViewDataProviders
extension AccountWalletsViewController.ViewModel {
    var numberOfItems: Int { walletsViewModels.value.count }
    
    func cellViewModel(for indexPath: IndexPath) -> WalletTableCell.ViewModel {
        walletsViewModels.value[indexPath.row]
    }
    
    func didSelectCell(at indexPath: IndexPath) {
        transitions.postDetails(cellViewModel(for: indexPath).id)
    }
}

private extension AccountWalletsViewController.ViewModel {
    func fetchWallets(fromCache: Bool = false) {
        ActivityIndicator.show()
        services.wallets.getWallets(
            fromCache: fromCache,
            success: { [weak self] wallets in
                self?.walletsViewModels.send(
                    wallets.compactMap {
                        guard let color = UIColor(hex: $0.colorHex) else { return nil }
                        let viewModel = WalletTableCell.ViewModel(
                            title: $0.name,
                            color: color
                        )
                        return viewModel
                    }
                )
                ActivityIndicator.hide()
            },
            failure: { [weak self] in
                ActivityIndicator.hide()
                self?.errorHandlerClosure($0)
            }
        )
    }
}

extension AccountWalletsViewController.ViewModel {
    func didTapComposeWalletButton() {
        transitions.composeWallet { [weak self] in
            self?.fetchWallets(fromCache: true)
        }
    }
}

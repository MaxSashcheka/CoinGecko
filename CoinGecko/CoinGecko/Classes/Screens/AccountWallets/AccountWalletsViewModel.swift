//
//  AccountWalletsViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 26.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import Core
import UIKit.UIColor
import Utils

extension AccountWalletsViewController {
    final class ViewModel: ScreenTransitionable, HandlersAccessible {
        private let services: Services
        let transitions: Transitions
        
        let walletsViewModels = CurrentValueSubject<[WalletTableCell.ViewModel], Never>([])
        
        var updateWalletsFromCacheClosure: Closure.Void {
            { [weak self] in self?.fetchWallets(fromCache: true) }
        }
        
        init(transitions: Transitions, services: Services) {
            self.services = services
            self.transitions = transitions
            
            fetchWallets()
        }
    }
}

// MARK: - AccountWalletsViewModel+NestedTypes
extension AccountWalletsViewController.ViewModel {
    struct Transitions: ScreenTransitions {
        let composeWallet: (@escaping Closure.Void) -> Void
        let walletDetails: (UUID, @escaping Closure.Void) -> Void
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
        transitions.walletDetails(cellViewModel(for: indexPath).id, updateWalletsFromCacheClosure)
    }
}

extension AccountWalletsViewController.ViewModel {
    func fetchWallets(fromCache: Bool = false) {
        activityIndicator.show()
        services.wallets.getWallets(
            fromCache: fromCache,
            success: { [weak self] wallets in
                self?.walletsViewModels.send(
                    wallets.compactMap {
                        guard let color = UIColor(hex: $0.colorHex) else { return nil }
                        let viewModel = WalletTableCell.ViewModel(
                            id: $0.id,
                            title: $0.name,
                            coinsCount: $0.coinsCount,
                            color: color
                        )
                        return viewModel
                    }
                )
                self?.activityIndicator.hide()
            },
            failure: errorsHandler.handleClosure(completion: activityIndicator.hideClosure)
        )
    }
}

extension AccountWalletsViewController.ViewModel {
    func didTapComposeWalletButton() {
        transitions.composeWallet(updateWalletsFromCacheClosure)
    }
}

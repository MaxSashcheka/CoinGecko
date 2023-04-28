//
//  AddCoinViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 28.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import Core
import Utils

extension AddCoinViewController {
    final class ViewModel: ErrorHandableViewModel, ScreenTransitionable {
        private let services: Services
        let transitions: Transitions
        
        let walletsViewModels = CurrentValueSubject<[AddCoinWalletTableCell.ViewModel], Never>([])
         
        init(transitions: Transitions, services: Services) {
            self.services = services
            self.transitions = transitions
            
            super.init()
            
            fetchWalletsData()
        }
    }
}

// MARK: - AddCoinViewModel+NestedTypes
extension AddCoinViewController.ViewModel {
    struct Transitions: ScreenTransitions {
        let close: Transition
    }
    
    final class Services {
        let wallets: WalletsServiceProtocol
        
        init(wallets: WalletsServiceProtocol) {
            self.wallets = wallets
        }
    }
}

// MARK: - AddCoinViewModel+TableViewDataProviders
extension AddCoinViewController.ViewModel {
    var numberOfItems: Int { walletsViewModels.value.count }
    
    func cellViewModel(for indexPath: IndexPath) -> AddCoinWalletTableCell.ViewModel {
        walletsViewModels.value[indexPath.row]
    }
    
    func didSelectCell(at indexPath: IndexPath) {
        walletsViewModels.value.forEach { $0.isSelected.send(false) }
        walletsViewModels.value[indexPath.row].isSelected.send(true)
    }
}

// MARK: - AddCoinViewModel+FetchData
private extension AddCoinViewController.ViewModel {
    func fetchWalletsData() {
        services.wallets.getWallets(
            fromCache: false,
            success: { [weak self] wallets in
                self?.walletsViewModels.send(
                    wallets.map {
                        AddCoinWalletTableCell.ViewModel(
                            id: $0.id, title: $0.name
                        )
                    }
                )
                self?.walletsViewModels.value.first?.isSelected.send(true)
            },
            failure: { [weak self] in self?.errorHandlerClosure?($0) }
        )
    }
}

// MARK: - AddCoinViewModel+TapActions
extension AddCoinViewController.ViewModel {
    func didTapCloseButton() {
        transitions.close()
    }
    
    func didTapDoneButton() {
        transitions.close()
    }
}

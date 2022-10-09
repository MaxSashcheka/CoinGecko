//
//  SearchViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 8.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Core
import Combine
import Utils

extension SearchViewController {
    final class ViewModel {
        private let coinsInteractor: CoinsInteractorProtocol
        
        var showCoinDetailInfoTransition: Closure.String?
        var errorHandlerClosure: Closure.APIError?
        
        let coinsViewModels = CurrentValueSubject<[CoinCell.ViewModel], Never>([])
        let nftsViewModels = CurrentValueSubject<[CoinCell.ViewModel], Never>([])
        var coinsCount: Int { coinsViewModels.value.count }
        var nftsCount: Int { nftsViewModels.value.count }
        
        var searchTextFieldViewModel = SearchTextField.ViewModel()
        
        init(coinsInteractor: CoinsInteractorProtocol) {
            self.coinsInteractor = coinsInteractor
            
        }
        
        func search(query: String) {
            coinsInteractor.search(query: query, success: { [weak self] searchResult in
                self?.coinsViewModels.send(
                    searchResult.coins.map { coin in
                        .init(
                            id: coin.id,
                            imageURL: coin.largeURL,
                            name: coin.name,
                            symbol: coin.symbol
                        )
                    }
                )
                
                self?.nftsViewModels.send(
                    searchResult.nfts.map { nft in
                        .init(
                            id: nft.id,
                            imageURL: nft.thumbURL,
                            name: nft.name
                        )
                    }
                )
            }, failure: { [weak self] in
                self?.errorHandlerClosure?($0)
            })
        }
        
        func cellViewModel(for indexPath: IndexPath) -> CoinCell.ViewModel {
            indexPath.section == 0
                ? coinsViewModels.value[indexPath.row]
                : nftsViewModels.value[indexPath.row]
        }
        
        func didSelectCoin(at indexPath: IndexPath) {
            guard indexPath.section == .zero else { return }
            showCoinDetailInfoTransition?(coinsViewModels.value[indexPath.row].id)
        }
    }
}

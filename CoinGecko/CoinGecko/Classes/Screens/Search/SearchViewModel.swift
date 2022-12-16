//
//  SearchViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 8.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import Core
import Utils

extension SearchViewController {
    final class ViewModel: ErrorHandableViewModel {
        private let coinsInteractor: CoinsInteractorProtocol
        
        var showCoinDetailInfoTransition: Closure.String?
        
        let coinsViewModels = CurrentValueSubject<[CoinCell.ViewModel], Never>([])
        let nftsViewModels = CurrentValueSubject<[CoinCell.ViewModel], Never>([])
        
        var searchTextFieldViewModel = SearchTextField.ViewModel()
        
        init(coinsInteractor: CoinsInteractorProtocol) {
            self.coinsInteractor = coinsInteractor
            
        }
    }
}

// MARK: - SearchViewController.ViewModel+Search
extension SearchViewController.ViewModel {
    func search(query: String) {
        coinsInteractor.search(query: query, success: { [weak self] searchResult in
            guard let self = self else { return }
            
            self.coinsViewModels.send(
                self.makeSearchResultCoinsViewModels(coins: searchResult.coins)
            )
            self.nftsViewModels.send(
                self.makeSearchResultNftsViewModels(nfts: searchResult.nfts)
            )
        }, failure: errorHandlerClosure)
    }
    
    func makeSearchResultCoinsViewModels(coins: [SearchCoin]) -> [CoinCell.ViewModel] {
        coins.map { coin in
            .init(id: coin.id, imageURL: coin.largeURL, name: coin.name, symbol: coin.symbol)
        }
    }
    
    func makeSearchResultNftsViewModels(nfts: [SearchNFT]) -> [CoinCell.ViewModel] {
        nfts.map { nft in
            .init(id: nft.id, imageURL: nft.thumbURL, name: nft.name.orEmpty())
        }
    }
}

// MARK: - SearchViewController.ViewModel+TableMethods
extension SearchViewController.ViewModel {
    var coinsCount: Int { coinsViewModels.value.count }
    var nftsCount: Int { nftsViewModels.value.count }
    
    func cellViewModel(for indexPath: IndexPath) -> CoinCell.ViewModel {
        indexPath.section == .zero
            ? coinsViewModels.value[indexPath.row]
            : nftsViewModels.value[indexPath.row]
    }
    
    func didSelectCoin(at indexPath: IndexPath) {
        guard indexPath.section == .zero else { return }
        showCoinDetailInfoTransition?(coinsViewModels.value[indexPath.row].id)
    }
}

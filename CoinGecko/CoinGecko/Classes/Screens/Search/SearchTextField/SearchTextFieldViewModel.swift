//
//  SearchTextFieldViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 9.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine

extension SearchTextField {
    final class ViewModel {
        let searchQuery = CurrentValueSubject<String, Never>(.empty)
        let returnSubject = PassthroughSubject<Void, Never>()
        
        func updateQuery(with newQuery: String) {
            searchQuery.send(newQuery)
        }
        
        func didTapReturnButton() {
            returnSubject.send(())
        }
    }
}

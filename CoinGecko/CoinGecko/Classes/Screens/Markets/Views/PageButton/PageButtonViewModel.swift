//
//  PageButtonViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 2.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import Utils

extension PageButton {
    final class ViewModel {
        enum DisplayMode: CaseIterable {
            case all, gainer, loser, favourites
        }
        
        let title = CurrentValueSubject<String, Never>(.empty)
        let displayMode = CurrentValueSubject<DisplayMode, Never>(.all)
        let isSelected = CurrentValueSubject<Bool, Never>(false)
        
        init(title: String, displayMode: DisplayMode, isSelected: Bool = false) {
            self.title.send(title)
            self.displayMode.send(displayMode)
        }
    }
}

extension PageButton.ViewModel.DisplayMode {
    var title: String {
        switch self {
        case .all: return "All"
        case .gainer: return "Gainer"
        case .loser: return "Loser"
        case .favourites: return "Favourites"
        }
    }
}

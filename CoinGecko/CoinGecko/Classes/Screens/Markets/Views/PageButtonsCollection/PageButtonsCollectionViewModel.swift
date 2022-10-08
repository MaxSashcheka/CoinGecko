//
//  PageButtonsCollectionViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 2.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine

extension PageButtonsCollectionView {
    final class ViewModel {
        enum DisplayMode: CaseIterable {
            case all, gainer, loser, favourites
        }
        
        let buttonsViewModels = CurrentValueSubject<[PageButton.ViewModel], Never>([])
        let selectModeSubject = PassthroughSubject<PageButton.ViewModel.DisplayMode, Never>()
        
        func selectButton(at index: Int) {
            let buttons = buttonsViewModels.value
            if buttons.isEmpty { return }
            buttons.filter { $0.isSelected.value }.forEach { $0.isSelected.send(false) }
            buttons[index].isSelected.send(true)
            selectModeSubject.send(buttons[index].displayMode.value)
        }
    }
}

//
//  ButtonCollectionViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 27.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import Foundation

extension ButtonsCollectionView {
    final class ViewModel {
        let buttonsViewModels = CurrentValueSubject<[RangePickerButton.ViewModel], Never>([])
        let selectTimeIntervalSubject = PassthroughSubject<TimeInterval, Never>()
        
        func selectButton(at index: Int) {
            let buttons = buttonsViewModels.value
            if buttons.isEmpty { return }
            buttons.filter { $0.isSelected.value }.forEach { $0.isSelected.send(false) }
            buttons[index].isSelected.send(true)
            selectTimeIntervalSubject.send(buttons[index].offsetTimeInterval.value)
        }
    }
}

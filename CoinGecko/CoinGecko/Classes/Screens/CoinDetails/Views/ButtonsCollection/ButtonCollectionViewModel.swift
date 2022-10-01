//
//  ButtonCollectionViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 27.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import RxCocoa
import RxSwift

extension ButtonsCollectionView {
    final class ViewModel {
        let buttonsViewModels = BehaviorRelay<[RangePickerButton.ViewModel]>(value: [])
        let selectTimeIntervalRelay = PublishRelay<TimeInterval>()
        var selectedButtonIndex: Int = .zero
        
        func selectButton(at index: Int) {
            let buttons = buttonsViewModels.value
            if buttons.isEmpty { return }
            buttons.filter { $0.isSelected.value }.forEach { $0.isSelected.accept(false) }
            buttons[index].isSelected.accept(true)
            selectTimeIntervalRelay.accept(buttons[index].offsetTimeInterval.value)
        }
    }
}

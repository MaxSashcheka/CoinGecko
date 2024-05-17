//
//  OptionPickerViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 17.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import Utils

extension OptionPickerView {
    final class ViewModel {
        let title = CurrentValueSubject<String, Never>(.empty)
        let selectedOption = CurrentValueSubject<Bool, Never>(false)
        
        init(title: String) {
            self.title.send(title)
        }
        
        func didTapButton(_ value: Bool) {
            selectedOption.send(value)
        }
    }
}

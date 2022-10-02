//
//  RangePickerButtonViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 25.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import Foundation

extension RangePickerButton {
    class ViewModel {
        let title = CurrentValueSubject<String, Never>(.empty)
        let offsetTimeInterval = CurrentValueSubject<TimeInterval, Never>(.zero)
        let isSelected = CurrentValueSubject<Bool, Never>(false)
        
        init(title: String, offsetTimeInterval: TimeInterval) {
            self.title.send(title)
            self.offsetTimeInterval.send(offsetTimeInterval)
        }
    }
}

//
//  RangePickerButtonViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 25.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import RxCocoa
import RxSwift

extension RangePickerButton {
    class ViewModel {
        let title = BehaviorRelay<String>(value: .empty)
        let offsetTimeInterval = BehaviorRelay<TimeInterval>(value: .zero)
        let isSelected = BehaviorRelay<Bool>(value: false)
        
        init(title: String, offsetTimeInterval: TimeInterval) {
            self.title.accept(title)
            self.offsetTimeInterval.accept(offsetTimeInterval)
        }
    }
}

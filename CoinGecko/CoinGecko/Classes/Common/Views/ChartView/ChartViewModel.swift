//
//  ChartViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 25.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import RxCocoa
import RxSwift

extension ChartView {
    final class ViewModel {
        let dataRelay = BehaviorRelay<[CGFloat]>(value: [])
        var chartData: [CGFloat] { dataRelay.value }
    }
}

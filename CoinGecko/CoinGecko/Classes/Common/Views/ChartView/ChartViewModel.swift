//
//  ChartViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 25.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import Foundation

extension ChartView {
    final class ViewModel {
        let dataSubject = CurrentValueSubject<[CGFloat], Never>([])
        var chartData: [CGFloat] { dataSubject.value }
    }
}

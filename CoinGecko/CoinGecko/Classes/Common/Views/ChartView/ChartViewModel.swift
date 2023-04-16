//
//  ChartViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 25.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import Core
import Foundation

extension ChartView {
    final class ViewModel {
        let dataSubject = CurrentValueSubject<[PriceMetadata], Never>([])
        let selectedMetadata = CurrentValueSubject<PriceMetadata?, Never>(nil)
        let updateMetadataSubject = PassthroughSubject<PriceMetadata, Never>()
        var chartData: [PriceMetadata] { dataSubject.value }
        
        func didSelectMetadata(at index: Int) {
            selectedMetadata.send(chartData[index])
        }
        
        func didEndPanning() {
            guard let metadata = selectedMetadata.value else { return }
            updateMetadataSubject.send(metadata)
        }
    }
}

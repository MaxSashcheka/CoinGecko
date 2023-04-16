//
//  PriceConverable.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 7.12.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Utils

protocol PriceConvertable { }

extension PriceConvertable {
    func roundedValueString(_ value: Double) -> String {
        var roundedValueString = preciseRound(value, precision: .thousandths).description
        roundedValueString.insert(contentsOf: "usd".currencySymbol, at: roundedValueString.startIndex)
        return roundedValueString
    }
    
    func roundedValuePriceChangeString(_ value: Double, isChangePositive: Bool) -> String {
        var priceChangeString = preciseRound(value, precision: .hundredths).description
        priceChangeString.insert(contentsOf: isChangePositive ? "+" : .empty,
                                 at: priceChangeString.startIndex)
        priceChangeString.insert(contentsOf: String.percent, at: priceChangeString.endIndex)
        return priceChangeString
    }
}

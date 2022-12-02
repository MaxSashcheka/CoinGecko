//
//  StringConverter.swift
//  Utils
//
//  Created by Maksim Sashcheka on 13.11.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Foundation

public class StringConverter {
    public static func roundedValueString(_ value: Double) -> String {
        var roundedValueString = preciseRound(value, precision: .thousandths).description
        roundedValueString.insert(contentsOf: "usd".currencySymbol, at: roundedValueString.startIndex)
        return roundedValueString
    }
    
    public static func roundedValuePriceChangeString(_ value: Double, isChangePositive: Bool) -> String {
        var priceChangeString = preciseRound(value, precision: .hundredths).description
        priceChangeString.insert(contentsOf: isChangePositive ? "+" : .empty,
                                 at: priceChangeString.startIndex)
        priceChangeString.insert(contentsOf: String.percent, at: priceChangeString.endIndex)
        return priceChangeString
    }
}

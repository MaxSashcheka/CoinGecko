//
//  Float.swift
//  Utils
//
//  Created by Maksim Sashcheka on 18.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Foundation

public enum RoundingPrecision {
    case ones, tenths, hundredths, thousandths, tenThousandths
}

// Round to the specific decimal place
public func preciseRound(_ value: Double, precision: RoundingPrecision = .ones) -> Double {
    switch precision {
    case .ones:
        return round(value)
    case .tenths:
        return round(value * 10) / 10.0
    case .hundredths:
        return round(value * 100) / 100.0
    case .thousandths:
        return round(value * 1000) / 1000.00
    case .tenThousandths:
        return round(value * 10000) / 1000.00
    }
}

//
//  TextPreferences.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 18.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import UIKit

public struct TextPreferences {
    let font: UIFont
    let textColor: UIColor
}

// MARK: - TextPreferences+StaticProperties
public extension TextPreferences {
    static let largeTitle = Self(font: .systemFont(ofSize: 30, weight: .bold),
                                 textColor: .black.withAlphaComponent(0.85))
    static let title = Self(font: .systemFont(ofSize: 20, weight: .medium),
                            textColor: .black)
    static let subTitle = Self(font: .systemFont(ofSize: 15, weight: .regular),
                               textColor: .darkGray)
}

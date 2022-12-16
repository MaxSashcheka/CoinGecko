//
//  TextStyle.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 18.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import UIKit

public struct TextStyle {
    let font: UIFont
    let textColor: UIColor
    
    public static func style(font: UIFont, textColor: UIColor) -> Self {
        Self(font: font, textColor: textColor)
    }
}

// MARK: - TextStyle+StaticProperties
public extension TextStyle {
//    static let largeTitle = Self(font: .systemFont(ofSize: 30, weight: .bold),
//                                 textColor: .black.withAlphaComponent(0.85))
//
//    static let title = Self(font: .systemFont(ofSize: 20, weight: .medium),
//                            textColor: .black.withAlphaComponent(0.85))
//
//    static let subtitle = Self(font: .systemFont(ofSize: 15, weight: .regular),
//                               textColor: .darkGray)
}

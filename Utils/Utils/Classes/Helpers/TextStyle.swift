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

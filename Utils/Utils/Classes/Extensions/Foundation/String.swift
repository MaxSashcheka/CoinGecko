//
//  String.swift
//  Utils
//
//  Created by Maksim Sashcheka on 18.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Foundation

public extension String {
    var firstUppercased: Self { prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: Self { prefix(1).capitalized + dropFirst() }
}

public extension String {
    static let empty = ""
    static let whitespace = " "
    static let percent = "%"
}

public extension String {
    var currencySymbol: Self {
        switch self {
        case "usd": return "$"
        default: return .empty
        }
    }
}

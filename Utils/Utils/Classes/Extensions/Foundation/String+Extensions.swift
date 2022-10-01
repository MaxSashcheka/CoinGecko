//
//  String.swift
//  Utils
//
//  Created by Maksim Sashcheka on 18.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import UIKit

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

public extension String {
    func height(withConstrainedWidth width: CGFloat = .infinity, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [NSAttributedString.Key.font: font],
                                            context: nil)
    
        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat = .infinity, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [NSAttributedString.Key.font: font],
                                            context: nil)

        return ceil(boundingBox.width)
    }
}

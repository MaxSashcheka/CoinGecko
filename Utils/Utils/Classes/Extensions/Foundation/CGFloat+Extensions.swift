//
//  CGFloat+Extensions.swift
//  Utils
//
//  Created by Maksim Sashcheka on 27.02.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import UIKit

public extension CGFloat {
    func precisedTo(digits power: Int) -> CGFloat {
        let delimiter = 10 ^^ power
        return (self * CGFloat(delimiter)).rounded(.toNearestOrEven) / CGFloat(delimiter)
    }
    
    func dependent(multiplier: CGFloat, precision: Int = 2) -> CGFloat {
        (self * multiplier).precisedTo(digits: precision)
    }
}

infix operator ^^
private func ^^ (radix: Int, power: Int) -> CGFloat {
    CGFloat(pow(Double(radix), Double(power)))
}

//public extension CGFloat {
//    static var pixel: CGFloat { 1 / UIScreen.main.scale }
//}
//
//public extension CGFloat {
//    func rounded(scale: CGFloat = UIScreen.main.scale) -> CGFloat {
//        ceil(self * scale) * (1 / scale)
//    }
//}
//
//public extension CGFloat {
//    func convertRadiansToDegrees() -> CGFloat {
//        self / .pi * 180
//    }
//    
//    func convertDegreesToRadians() -> CGFloat {
//        self * .pi / 180
//    }
//}
//
//public extension CGSize {
//    func rounded(scale: CGFloat = UIScreen.main.scale) -> CGSize {
//        CGSize(width: width.rounded(scale: scale), height: height.rounded(scale: scale))
//    }
//}

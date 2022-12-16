//
//  TimeInterval+Extensions.swift
//  Utils
//
//  Created by Maksim Sashcheka on 27.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Foundation

public extension TimeInterval {
    static let second: Self = 1
    static let minute: Self = second * 60
    static let hour: Self = minute * 60
    static let day: Self = hour * 24
    static let week: Self = day * 7
    static let month: Self = day * 30
    static let halfYear: Self = month * 6
    static let year: Self = month * 12
    
    static let intervalSince1970: Self = Date().timeIntervalSince1970
    
    var offsetFromCurrentTime: Self { Double.intervalSince1970 - self }
}

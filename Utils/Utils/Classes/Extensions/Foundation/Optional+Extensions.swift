//
//  Optional.swift
//  Utils
//
//  Created by Maksim Sashcheka on 17.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Foundation

public extension Optional where Wrapped == String {
    func orEmpty() -> Wrapped { self ?? "" }
    func isNilOrEmpty() -> Bool { orEmpty().isEmpty }
}

public extension Optional {
    var isNil: Bool { self == nil }
    var nonNil: Bool { !isNil }
}

//
//  ParametersProvider.swift
//  Core
//
//  Created by Maksim Sashcheka on 1.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Foundation

public protocol ParametersProvider {
    var parameters: [String: Any] { get }
}

extension Dictionary: ParametersProvider {
    public var parameters: [String: Any] {
        let anySelf: Any = self
        
        switch anySelf {
        case let dict as [String: Any]:
            return dict
        case let dict as [String: String]:
            return dict
        case let dict as [String: String?]:
            return dict.compactMapValues { $0 }
        default: return [:]
        }
    }
}

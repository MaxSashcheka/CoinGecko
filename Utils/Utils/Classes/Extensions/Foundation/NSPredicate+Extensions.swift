//
//  NSPredicate+Extensions.swift
//  Utils
//
//  Created by Maksim Sashcheka on 5.11.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Foundation
import CoreData

public extension NSPredicate {
    static func notEqualTo(_ value: CVarArg,
                           keyPath: String,
                           operationOptions: String = .empty) -> NSPredicate {
        NSPredicate(format: "%K !=\(operationOptions) %@", keyPath, value)
    }
    
    static func equalTo(_ value: CVarArg,
                        keyPath: String,
                        operationOptions: String = .empty) -> NSPredicate {
        NSPredicate(format: "%K ==\(operationOptions) %@", keyPath, value)
    }
}

public extension NSPredicate {
    static func combine(predicates: [NSPredicate],
                        using operation: NSCompoundPredicate.LogicalType) -> NSPredicate {
        NSCompoundPredicate(type: operation, subpredicates: predicates)
    }
    
    static func combine(predicates: [NSPredicate?],
                        using operation: NSCompoundPredicate.LogicalType) -> NSPredicate {
        combine(predicates: predicates.compactMap { $0 }, using: operation)
    }
}

public extension NSPredicate {
    static func alwaysTrue() -> NSPredicate {
        NSPredicate(value: true)
    }
    
    static func alwaysFalse() -> NSPredicate {
        NSPredicate(value: false)
    }
}

public extension NSPredicate {
    static func notEqualTo(_ value: Bool, keyPath: String) -> NSPredicate {
        notEqualTo(NSNumber(value: value), keyPath: keyPath)
    }
    
    static func equalTo(_ value: Bool, keyPath: String) -> NSPredicate {
        equalTo(NSNumber(value: value), keyPath: keyPath)
    }
}

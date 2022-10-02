//
//  DispatchQueue+Extensions.swift
//  Utils
//
//  Created by Maksim Sashcheka on 2.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Foundation

public extension DispatchQueue {
    static func asyncDispatchToMainIfNeeded(action: @escaping Closure.Void) {
        if Thread.isMainThread {
            action()
        } else {
            DispatchQueue.main.async(execute: action)
        }
    }
    
    static func syncDispatchToMainIfNeeded<T>(block: () throws -> T) rethrows -> T {
        if Thread.isMainThread {
            return try block()
        } else {
            return try DispatchQueue.main.sync(execute: block)
        }
    }
}

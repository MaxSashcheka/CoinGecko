//
//  Array+Extensions.swift
//  Utils
//
//  Created by Maksim Sashcheka on 17.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Foundation

public extension Array where Element: Hashable {
    mutating func append<S>(contentsOf newElements: S, unique: Bool = false) where S: Sequence, Element == S.Element {
        guard unique else {
            append(contentsOf: newElements)
            return
        }
        
        newElements.forEach { append($0, unique: unique) }
    }
    
    mutating func append(_ newElement: Element, unique: Bool = false) {
        guard unique else {
            self.append(newElement)
            return
        }

        if !contains(newElement) {
            self.append(newElement)
        } else if let index = firstIndex(of: newElement) {
            self[index] = newElement
        }
    }
    
    subscript (safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

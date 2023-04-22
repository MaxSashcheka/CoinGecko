//
//  CacheContainer.swift
//  Utils
//
//  Created by Maksim Sashcheka on 22.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Foundation

public protocol CacheContainerConformable {
    associatedtype CacheItemIdentifierType: Hashable

    var cacheItemIdentifer: CacheItemIdentifierType { get }
}

public class CacheContainer<CacheItemUniqueKey, CacheItemType: CacheContainerConformable> where CacheItemUniqueKey == CacheItemType.CacheItemIdentifierType {
    private var items: [CacheItemType] = []
    
    public var allItems: [CacheItemType] { items }
    
    public var isEmpty: Bool { items.isEmpty }
    
    public var count: Int { items.count }

    public init() { }
    
    public func clear() {
        items.removeAll()
    }

    public subscript(identifier: CacheItemUniqueKey) -> CacheItemType? {
        items.first(where: { $0.cacheItemIdentifer == identifier })
    }
    
    public func append(contentsOf items: [CacheItemType]) {
        items.forEach { append($0) }
    }
    
    public func append(_ item: CacheItemType) {
        if let index = items.firstIndex(where: { $0.cacheItemIdentifer == item.cacheItemIdentifer }) {
            items[index] = item
        } else {
            items.append(item)
        }
    }
    
    public func removeItem(_ item: CacheItemType) {
        removeItem(with: item.cacheItemIdentifer)
    }
    
    public func removeItem(with key: CacheItemUniqueKey) {
        guard let index = items.firstIndex(where: { $0.cacheItemIdentifer == key }) else {
            return
        }
        items.remove(at: index)
    }
}

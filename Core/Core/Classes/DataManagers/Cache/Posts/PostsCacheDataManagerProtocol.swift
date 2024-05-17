//
//  PostsCacheDataManagerProtocol.swift
//  Core
//
//  Created by Maksim Sashcheka on 23.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

public protocol PostsCacheDataManagerProtocol {
    var cachedPosts: CacheContainer<UUID, Post> { get }
}

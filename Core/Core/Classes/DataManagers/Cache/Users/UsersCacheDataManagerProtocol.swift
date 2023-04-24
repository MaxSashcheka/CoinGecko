//
//  UsersCacheDataManagerProtocol.swift
//  Core
//
//  Created by Maksim Sashcheka on 24.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

public protocol UsersCacheDataManagerProtocol {
    var cachedUsers: CacheContainer<UUID, User> { get set }
    var currentUser: User? { get set }
    
    func updateCurrentUser(_ user: User)
    func clearCurrentUser()
}

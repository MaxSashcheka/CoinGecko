//
//  UsersCacheDataManager.swift
//  Core
//
//  Created by Maksim Sashcheka on 24.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

public final class UsersCacheDataManager: UsersCacheDataManagerProtocol {
    public var cachedUsers = CacheContainer<UUID, User>()
    
    public var currentUser: User?
    
    public init() { }
}

public extension UsersCacheDataManager {
    func updateCurrentUser(_ user: User) {
        self.currentUser = user
        cachedUsers.append(user)
    }

    func clearCurrentUser() {
        self.currentUser = nil
    }
}

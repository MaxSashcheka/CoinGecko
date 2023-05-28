//
//  UsersService.swift
//  Core
//
//  Created by Maksim Sashcheka on 25.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

public final class UsersService: UsersServiceProtocol {
    private let appPropertiesDataManager: AppPropertiesDataManager
    private let usersCacheDataManager: UsersCacheDataManagerProtocol
    private let usersAPIDataManager: UsersAPIDataManagerProtocol
    
    public var currentUser: User? {
        usersCacheDataManager.currentUser
    }
    
    public init(appPropertiesDataManager: AppPropertiesDataManager,
                usersCacheDataManager: UsersCacheDataManagerProtocol,
                usersAPIDataManager: UsersAPIDataManagerProtocol) {
        self.appPropertiesDataManager = appPropertiesDataManager
        self.usersCacheDataManager = usersCacheDataManager
        self.usersAPIDataManager = usersAPIDataManager
    }
    
    public func clearCurrentUser() {
        appPropertiesDataManager[.user] = nil as User?
        usersCacheDataManager.clearCurrentUser()
    }
    
    public func fetchUsers(fromCache: Bool = true,
                           success: @escaping Closure.UsersArray,
                           failure: @escaping Closure.GeneralError) {
        if fromCache {
            success(usersCacheDataManager.cachedUsers.allItems)
            return
        }
        
        usersAPIDataManager.fetchAllUsers(
            success: { [weak self] in
                self?.usersCacheDataManager.cachedUsers.append(contentsOf: $0)
                success($0)
            },
            failure: failure)
    }
    
    public func fetchUser(id: UUID,
                          fromCache: Bool = true,
                          success: @escaping Closure.User,
                          failure: @escaping Closure.GeneralError) {
        if fromCache, let cachedUser = usersCacheDataManager.cachedUsers[id] {
            success(cachedUser)
            return
        }
        
        usersAPIDataManager.fetchUser(
            id: id,
            success: { [weak self] in
                self?.usersCacheDataManager.cachedUsers.append($0)
                success($0)
            },
            failure: failure
        )
    }
}

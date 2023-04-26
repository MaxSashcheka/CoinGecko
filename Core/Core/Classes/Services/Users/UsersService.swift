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
    
    public var currentUser: User? {
        usersCacheDataManager.currentUser
    }
    
    public init(appPropertiesDataManager: AppPropertiesDataManager,
                usersCacheDataManager: UsersCacheDataManagerProtocol) {
        self.appPropertiesDataManager = appPropertiesDataManager
        self.usersCacheDataManager = usersCacheDataManager
    }
    
    public func clearCurrentUser() {
        appPropertiesDataManager[.user] = nil as User?
        usersCacheDataManager.clearCurrentUser()
    }
}

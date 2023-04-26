//
//  ComposeUserService.swift
//  Core
//
//  Created by Maksim Sashcheka on 16.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils
import UIKit.UIImage

public class ComposeUserService: ComposeUserServiceProtocol {
    private let appPropertiesDataManager: AppPropertiesDataManager
    private let composeUserCacheDataManager: ComposeUserCacheDataManagerProtocol
    private let usersCacheDataManager: UsersCacheDataManagerProtocol
    private let usersAPIDataManager: UsersAPIDataManagerProtocol
    
    public init(appPropertiesDataManager: AppPropertiesDataManager,
                composeUserCacheDataManager: ComposeUserCacheDataManagerProtocol,
                usersCacheDataManager: UsersCacheDataManagerProtocol,
                usersAPIDataManager: UsersAPIDataManagerProtocol) {
        self.appPropertiesDataManager = appPropertiesDataManager
        self.composeUserCacheDataManager = composeUserCacheDataManager
        self.usersCacheDataManager = usersCacheDataManager
        self.usersAPIDataManager = usersAPIDataManager
    }
}

// MARK: ComposeUserService+ComputedProperties
public extension ComposeUserService {
    var username: String? {
        get { composeUserCacheDataManager.username }
        set { composeUserCacheDataManager.username = newValue }
    }
    
    var login: String? {
        get { composeUserCacheDataManager.login }
        set { composeUserCacheDataManager.login = newValue }
    }
    
    var password: String? {
        get { composeUserCacheDataManager.password }
        set { composeUserCacheDataManager.password = newValue }
    }
    
    var email: String? {
        get { composeUserCacheDataManager.email }
        set { composeUserCacheDataManager.email = newValue }
    }
    
    var role: String? {
        get { composeUserCacheDataManager.role }
        set { composeUserCacheDataManager.role = newValue }
    }
    
    var personalWebLink: String? {
        get { composeUserCacheDataManager.personalWebLink }
        set { composeUserCacheDataManager.personalWebLink = newValue }
    }
    
    var image: UIImage? {
        get { composeUserCacheDataManager.image }
        set { composeUserCacheDataManager.image = newValue }
    }
}

// MARK: ComposeUserService+Methods
public extension ComposeUserService {
    func submitUser(imageURL: String,
                    success: @escaping Closure.Void,
                    failure: @escaping Closure.GeneralError) {
        guard let username = username,
              let login = login,
              let password = password,
              let email = email,
              let role = role else {
            failure(.defaultError)
            return
        }
        usersAPIDataManager.createUser(
            username: username,
            login: login,
            password: password,
            email: email,
            role: role,
            personalWebLink: personalWebLink.orEmpty(),
            imageURL: imageURL,
            success: { [weak self] in
                self?.appPropertiesDataManager[.user] = $0
                self?.usersCacheDataManager.updateCurrentUser($0)
                success()
            },
            failure: failure
        )
    }
}

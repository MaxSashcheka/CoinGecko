//
//  ComposeUserService.swift
//  Core
//
//  Created by Maksim Sashcheka on 16.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import UIKit.UIImage

public class ComposeUserService: ComposeUserServiceProtocol {
    private let composeUserCacheDataManager: ComposeUserCacheDataManagerProtocol
    
    public var username: String? {
        get { composeUserCacheDataManager.username }
        set { composeUserCacheDataManager.username = newValue }
    }
    
    public var login: String? {
        get { composeUserCacheDataManager.login }
        set { composeUserCacheDataManager.login = newValue }
    }
    
    public var password: String? {
        get { composeUserCacheDataManager.password }
        set { composeUserCacheDataManager.password = newValue }
    }
    
    public var email: String? {
        get { composeUserCacheDataManager.email }
        set { composeUserCacheDataManager.email = newValue }
    }
    
    public var personalWebLink: String? {
        get { composeUserCacheDataManager.personalWebLink }
        set { composeUserCacheDataManager.personalWebLink = newValue }
    }
    
    public var image: UIImage? {
        get { composeUserCacheDataManager.image }
        set { composeUserCacheDataManager.image = newValue }
    }
    
    public init(composeUserCacheDataManager: ComposeUserCacheDataManagerProtocol) {
        self.composeUserCacheDataManager = composeUserCacheDataManager
    }
}

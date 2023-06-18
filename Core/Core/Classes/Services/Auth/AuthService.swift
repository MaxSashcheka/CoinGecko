//
//  AuthService.swift
//  Core
//
//  Created by Maksim Sashcheka on 24.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

public final class AuthService: AuthServiceProtocol {
    private let appPropertiesDataManager: AppPropertiesDataManager
    private let usersCacheDataManager: UsersCacheDataManagerProtocol
    private let authAPIDataManager: AuthAPIDataManagerProtocol
    
    public init(appPropertiesDataManager: AppPropertiesDataManager,
                usersCacheDataManager: UsersCacheDataManagerProtocol,
                authAPIDataManager: AuthAPIDataManagerProtocol) {
        self.appPropertiesDataManager = appPropertiesDataManager
        self.usersCacheDataManager = usersCacheDataManager
        self.authAPIDataManager = authAPIDataManager
    }
    
    public func login(login: String,
                      password: String,
                      success: @escaping Closure.Void,
                      failure: @escaping Closure.ServiceError) {
        authAPIDataManager.login(
            login: login,
            password: password,
            success: { [weak self] in
                self?.appPropertiesDataManager[.user] = $0
                self?.usersCacheDataManager.updateCurrentUser($0)
                success()
            },
            failure: ServiceError.wrap(failure, code: .login)
        )
    }
}



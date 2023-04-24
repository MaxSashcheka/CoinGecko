//
//  AuthService.swift
//  Core
//
//  Created by Maksim Sashcheka on 24.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

public final class AuthService: AuthServiceProtocol {
    private let usersCacheDataManager: UsersCacheDataManagerProtocol
    private let authAPIDataManager: AuthAPIDataManagerProtocol
    
    public init(usersCacheDataManager: UsersCacheDataManagerProtocol,
                authAPIDataManager: AuthAPIDataManagerProtocol) {
        self.usersCacheDataManager = usersCacheDataManager
        self.authAPIDataManager = authAPIDataManager
    }
    
    public func login(login: String,
                      password: String,
                      success: @escaping Closure.Void,
                      failure: @escaping Closure.GeneralError) {
        authAPIDataManager.login(
            login: login,
            password: password,
            success: { [weak self] in
                self?.usersCacheDataManager.updateCurrentUser($0)
                success()
            },
            failure: failure
        )
    }
}



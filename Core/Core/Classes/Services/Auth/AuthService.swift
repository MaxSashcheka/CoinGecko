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
                      completion: @escaping Completion<Void, ServiceError>) {
        authAPIDataManager.login(
            login: login,
            password: password,
            completion: { [weak self] result in
                switch result {
                case .success(let user):
                    self?.appPropertiesDataManager[.user] = user
                    self?.usersCacheDataManager.updateCurrentUser(user)
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(ServiceError(code: .login, underlying: error)))
                }
            }
        )
    }
}



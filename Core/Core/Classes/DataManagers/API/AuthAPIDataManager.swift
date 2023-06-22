//
//  AuthAPIDataManager.swift
//  Core
//
//  Created by Maksim Sashcheka on 24.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

public final class AuthAPIDataManager: APIDataManager, AuthAPIDataManagerProtocol {
    public func login(login: String,
                      password: String,
                      completion: @escaping Completion<User, APIError>) {
        let endpoint = RequestDescription.Users.login
            .replacingParameters(
                .login(login: login, password: password)
            )
        
        execute(
            request: makeDataRequest(for: endpoint),
            errorCode: .login,
            responseType: UserResponse.self,
            completion: { result in
                switch result {
                case .success(let response):
                    completion(.success(User(userResponse: response)))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        )
    }
}

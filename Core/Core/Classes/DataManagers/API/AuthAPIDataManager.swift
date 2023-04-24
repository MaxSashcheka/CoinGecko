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
                      success: @escaping Closure.User,
                      failure: @escaping Closure.GeneralError) {
        let endpoint = RequestDescription.Users.login
            .replacingParameters(
                .login(login: login, password: password)
            )
        
        execute(
            request: makeDataRequest(for: endpoint),
            responseType: UserResponse.self,
            success: { success(User(userResponse: $0)) },
            failure: failure
        )
    }
}

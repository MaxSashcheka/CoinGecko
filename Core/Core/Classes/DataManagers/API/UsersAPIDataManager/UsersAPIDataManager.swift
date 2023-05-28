//
//  UsersAPIDataManager.swift
//  Core
//
//  Created by Maksim Sashcheka on 18.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

public final class UsersAPIDataManager: APIDataManager, UsersAPIDataManagerProtocol {
    public func createUser(username: String,
                           login: String,
                           password: String,
                           email: String,
                           role: String,
                           personalWebLink: String,
                           imageURL: String,
                           success: @escaping Closure.User,
                           failure: @escaping Closure.GeneralError) {
        let endpoint = RequestDescription.Users.createUser
            .replacingParameters(
                .createUser(
                    id: UUID().uuidString,
                    name: username,
                    login: login,
                    password: password,
                    role: role,
                    imageURL: imageURL,
                    email: email,
                    personalWebPageURL: personalWebLink
                )
            )
        
        execute(
            request: makeDataRequest(for: endpoint),
            responseType: UserResponse.self,
            success: { success(User(userResponse: $0)) },
            failure: failure
        )
    }
    
    public func fetchAllUsers(success: @escaping Closure.UsersArray,
                              failure: @escaping Closure.GeneralError) {
        let endpoint = RequestDescription.Users.getAllUsers

        execute(
            request: makeDataRequest(for: endpoint),
            responseType: [UserResponse].self,
            success: { success($0.map { User(userResponse: $0) }) },
            failure: failure
        )
    }
    
    public func fetchUser(id: UUID,
                          success: @escaping Closure.User,
                          failure: @escaping Closure.GeneralError) {
        let endpoint = RequestDescription.Users.getUserById
            .replacingParameters(.id(id.uuidString))
        
        execute(
            request: makeDataRequest(for: endpoint),
            responseType: UserResponse.self,
            success: { success(User(userResponse: $0)) },
            failure: failure
        )
    }
}

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
                           completion: @escaping Completion<User, APIError>) {
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
            errorCode: .createUser,
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
    
    public func fetchAllUsers(completion: @escaping Completion<[User], APIError>) {
        let endpoint = RequestDescription.Users.getAllUsers

        execute(
            request: makeDataRequest(for: endpoint),
            errorCode: .fetchAllUsers,
            responseType: [UserResponse].self,
            completion: { result in
                switch result {
                case .success(let response):
                    completion(.success(response.map { User(userResponse: $0) }))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        )
    }
    
    public func fetchUser(id: UUID,
                          completion: @escaping Completion<User, APIError>) {
        let endpoint = RequestDescription.Users.getUserById
            .replacingParameters(.id(id.uuidString))
        
        execute(
            request: makeDataRequest(for: endpoint),
            errorCode: .fetchUser,
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

//
//  UsersAPIDataManagerProtocol.swift
//  Core
//
//  Created by Maksim Sashcheka on 18.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

public protocol UsersAPIDataManagerProtocol {
    func createUser(username: String,
                    login: String,
                    password: String,
                    email: String,
                    role: String,
                    personalWebLink: String,
                    imageURL: String,
                    success: @escaping Closure.User,
                    failure: @escaping Closure.APIError)
    
    func fetchAllUsers(success: @escaping Closure.UsersArray,
                       failure: @escaping Closure.APIError)
    
    func fetchUser(id: UUID,
                   success: @escaping Closure.User,
                   failure: @escaping Closure.APIError)
}

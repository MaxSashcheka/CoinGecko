//
//  AuthAPIDataManagerProtocol.swift
//  Core
//
//  Created by Maksim Sashcheka on 24.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

public protocol AuthAPIDataManagerProtocol {
    func login(login: String,
               password: String,
               completion: @escaping Completion<User, APIError>)
}

//
//  AuthServiceProtocol.swift
//  Core
//
//  Created by Maksim Sashcheka on 24.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

public protocol AuthServiceProtocol {
    func login(login: String,
               password: String,
               success: @escaping Closure.Void,
               failure: @escaping Closure.GeneralError)
}


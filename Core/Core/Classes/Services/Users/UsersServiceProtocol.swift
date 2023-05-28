//
//  UsersServiceProtocol.swift
//  Core
//
//  Created by Maksim Sashcheka on 25.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

public protocol UsersServiceProtocol {
    var currentUser: User? { get }
    
    func clearCurrentUser()
    
    func fetchUsers(fromCache: Bool,
                    success: @escaping Closure.UsersArray,
                    failure: @escaping Closure.GeneralError)
    
    func fetchUser(id: UUID,
                   fromCache: Bool,
                   success: @escaping Closure.User,
                   failure: @escaping Closure.GeneralError)
}

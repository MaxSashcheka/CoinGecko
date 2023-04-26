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
}

//
//  User.swift
//  Core
//
//  Created by Maksim Sashcheka on 22.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

public extension Closure {
    typealias User = (Core.User) -> Swift.Void
    typealias UsersArray = ([Core.User]) -> Swift.Void
}

public struct User {
    public enum Role: String {
        case user = "User"
        case admin = "Admin"
    }
    
    public let id: String
    public let name: String
    public let login: String
    public let email: String
    public let role: Role
    public let imageURL: URL?
    public let webPageURL: URL?
}

public extension User {
    init(userResponse: UserResponse) {
        self.id = userResponse.id
        self.name = userResponse.name
        self.login = userResponse.login
        self.email = userResponse.email
        self.imageURL = URL(string: userResponse.imageURL)
        self.webPageURL = URL(string: userResponse.personalWebPageURL)
        self.role = Role(rawValue: userResponse.role) ?? .user
    }
}

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
    public init(id: UUID, name: String, login: String, email: String, role: User.Role, imageURL: URL? = nil, webPageURL: URL? = nil) {
        self.id = id
        self.name = name
        self.login = login
        self.email = email
        self.role = role
        self.imageURL = imageURL
        self.webPageURL = webPageURL
    }
    
    public enum Role: String {
        case user = "User"
        case admin = "Admin"
    }
    
    public let id: UUID
    public let name: String
    public let login: String
    public let email: String
    public let role: Role
    public let imageURL: URL?
    public let webPageURL: URL?
    
    
}

public extension User {
    init(userResponse: UserResponse) {
        self.id = UUID(uuidString: userResponse.id) ?? UUID()
        self.name = userResponse.name
        self.login = userResponse.login
        self.email = userResponse.email
        self.imageURL = URL(string: userResponse.imageURL)
        self.webPageURL = URL(string: userResponse.personalWebPageURL)
        self.role = Role(rawValue: userResponse.role) ?? .user
    }
}

extension User: CacheContainerConformable {
    public var cacheItemIdentifer: UUID { id }
}

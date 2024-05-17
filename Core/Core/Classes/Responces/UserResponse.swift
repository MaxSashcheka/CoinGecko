//
//  UserResponse.swift
//  Core
//
//  Created by Maksim Sashcheka on 18.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Foundation

public struct UserResponse: Decodable {
    public let id: String
    public let name: String
    public let login: String
    public let email: String
    public let role: String
    public let personalWebPageURL: String
    public let imageURL: String
}

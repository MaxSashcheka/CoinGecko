//
//  User+AppPropertyCodable.swift
//  Core
//
//  Created by Maksim Sashcheka on 26.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Foundation

extension User: AppPropertyCodable {
    private enum Fields {
        static let id = "id"
        static let name = "name"
        static let login = "login"
        static let email = "email"
        static let role = "role"
        static let imageURL = "imageURL"
        static let webPageURL = "webPageURL"
    }
    
    public var appPropertyValue: NSCoding {
        var fields: [String: Any] = [
            Fields.id: id.uuidString,
            Fields.name: name,
            Fields.login: login,
            Fields.email: email,
            Fields.role: role.rawValue
        ]
        if let imageURL = imageURL {
            fields[Fields.imageURL] = imageURL.absoluteString
        }
        if let webPageURL = webPageURL {
            fields[Fields.webPageURL] = webPageURL.absoluteString
        }
        
        return fields as NSDictionary
    }
    
    public init?(appPropertyValue: NSCoding) {
        guard let dict = appPropertyValue as? [String: Any] else {
            return nil
        }
        guard let idString = dict[Fields.id] as? String,
              let id = UUID(uuidString: idString),
              let name = dict[Fields.name] as? String,
              let login = dict[Fields.login] as? String,
              let email = dict[Fields.email] as? String,
              let roleRawValue = dict[Fields.role] as? String,
              let role = Role(rawValue: roleRawValue) else {
            return nil
        }
        self.id = id
        self.name = name
        self.login = login
        self.email = email
        self.role = role
        
        if let imageURLString = dict[Fields.imageURL] as? String,
           let imageURL = URL(string: imageURLString) {
            self.imageURL = imageURL
        } else {
            self.imageURL = nil
        }
        
        if let webPageURLString = dict[Fields.webPageURL] as? String,
           let webPageURL = URL(string: webPageURLString) {
            self.webPageURL = webPageURL
        } else {
            self.webPageURL = nil
        }
    }
}

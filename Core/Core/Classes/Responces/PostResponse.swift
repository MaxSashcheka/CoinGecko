//
//  PostResponse.swift
//  Core
//
//  Created by Maksim Sashcheka on 23.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Foundation

public struct PostResponse: Decodable {
    public let id: String
    public let title: String
    public let content: String
    public let authorId: String
    public let imageURL: String
}

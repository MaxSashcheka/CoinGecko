//
//  Post.swift
//  Core
//
//  Created by Maksim Sashcheka on 23.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

public extension Closure {
    typealias OptionalPost = (Core.Post?) -> Swift.Void
    typealias Post = (Core.Post) -> Swift.Void
    typealias PostsArray = ([Core.Post]) -> Swift.Void
}

public struct Post {
    public let id: UUID
    public let title: String
    public let content: String
    public let imageURL: URL?
    public let authorId: UUID
}

public extension Post {
    init(postResponse: PostResponse) {
        self.id = UUID(uuidString: postResponse.id) ?? UUID()
        self.title = postResponse.title
        self.content = postResponse.content
        self.imageURL = URL(string: postResponse.imageURL)
        self.authorId = UUID(uuidString: postResponse.authorId) ?? UUID()
    }
}

// MARK: Post+CacheContainerConformable
extension Post: CacheContainerConformable {
    public var cacheItemIdentifer: UUID { id }
}

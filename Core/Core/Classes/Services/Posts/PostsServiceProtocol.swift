//
//  PostsServiceProtocol.swift
//  Core
//
//  Created by Maksim Sashcheka on 23.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

public protocol PostsServiceProtocol {
    func getPosts(fromCache: Bool,
                  completion: @escaping Completion<[Post], ServiceError>)
    
    func getPost(id: UUID,
                 fromCache: Bool,
                 completion: @escaping Completion<Post, ServiceError>)
}

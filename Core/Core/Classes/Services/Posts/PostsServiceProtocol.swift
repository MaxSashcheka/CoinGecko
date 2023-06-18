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
                  success: @escaping Closure.PostsArray,
                  failure: @escaping Closure.ServiceError)
    
    func getPost(id: UUID,
                 fromCache: Bool,
                 success: @escaping Closure.Post,
                 failure: @escaping Closure.ServiceError)
}

//
//  PostsAPIDataManagerProtocol.swift
//  Core
//
//  Created by Maksim Sashcheka on 23.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

public protocol PostsAPIDataManagerProtocol {
    func createPost(title: String,
                    content: String,
                    authorId: UUID,
                    imageURL: String,
                    success: @escaping Closure.Post,
                    failure: @escaping Closure.APIError)
    
    func getAllPosts(success: @escaping Closure.PostsArray,
                     failure: @escaping Closure.APIError)
    
    func getPost(id: UUID,
                 success: @escaping Closure.Post,
                 failure: @escaping Closure.APIError)
}

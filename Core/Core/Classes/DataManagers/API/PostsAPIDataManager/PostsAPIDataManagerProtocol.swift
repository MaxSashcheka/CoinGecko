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
                    completion: @escaping Completion<Post, APIError>)
    
    func getAllPosts(completion: @escaping Completion<[Post], APIError>)
    
    func getPost(id: UUID,
                 completion: @escaping Completion<Post, APIError>)
}

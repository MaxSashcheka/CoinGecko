//
//  PostsAPIDataManager.swift
//  Core
//
//  Created by Maksim Sashcheka on 23.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

public final class PostsAPIDataManager: APIDataManager, PostsAPIDataManagerProtocol {
    public func createPost(title: String,
                           content: String,
                           authorId: UUID,
                           imageURL: String,
                           success: @escaping Closure.Post,
                           failure: @escaping Closure.GeneralError) {
        let endpoint = RequestDescription.Posts.createPost
            .replacingParameters(
                .createPost(
                    id: UUID().uuidString,
                    title: title,
                    content: content,
                    authorId: authorId.uuidString,
                    imageURL: imageURL
                )
            )
        
        execute(
            request: makeDataRequest(for: endpoint),
            responseType: PostResponse.self,
            success: { success(Post(postResponse: $0)) },
            failure: failure
        )
    }
    
    public func getAllPosts(success: @escaping Closure.PostsArray,
                            failure: @escaping Closure.GeneralError) {
        let endpoint = RequestDescription.Posts.getAllPosts
            
        execute(
            request: makeDataRequest(for: endpoint),
            responseType: [PostResponse].self,
            success: { success($0.map { Post(postResponse: $0) }) },
            failure: failure
        )
    }
}

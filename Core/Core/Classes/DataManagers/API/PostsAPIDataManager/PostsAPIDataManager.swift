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
                           completion: @escaping Completion<Post, APIError>) {
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
            errorCode: .createPost,
            responseType: PostResponse.self,
            completion: { result in
                switch result {
                case .success(let response):
                    completion(.success(Post(postResponse: response)))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        )
    }
    
    public func getAllPosts(completion: @escaping Completion<[Post], APIError>) {
        let endpoint = RequestDescription.Posts.getAllPosts
            
        execute(
            request: makeDataRequest(for: endpoint),
            errorCode: .getAllPosts,
            responseType: [PostResponse].self,
            completion: { result in
                switch result {
                case .success(let response):
                    completion(.success(response.map { Post(postResponse: $0) }))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        )
    }
    
    public func getPost(id: UUID,
                        completion: @escaping Completion<Post, APIError>) {
        let endpoint = RequestDescription.Posts.getPost
            .replacingInlineArguments(
                .id(id.uuidString)
            )
        
        execute(
            request: makeDataRequest(for: endpoint),
            errorCode: .getPost,
            responseType: PostResponse.self,
            completion: { result in
                switch result {
                case .success(let response):
                    completion(.success(Post(postResponse: response)))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        )
    }
}

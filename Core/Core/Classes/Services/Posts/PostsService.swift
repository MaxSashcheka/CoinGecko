//
//  PostsService.swift
//  Core
//
//  Created by Maksim Sashcheka on 23.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

public final class PostsService: PostsServiceProtocol {
    private let postsCacheDataManager: PostsCacheDataManagerProtocol
    private let postsAPIDataManager: PostsAPIDataManagerProtocol
    
    public init(postsCacheDataManager: PostsCacheDataManagerProtocol,
                postsAPIDataManager: PostsAPIDataManagerProtocol) {
        self.postsCacheDataManager = postsCacheDataManager
        self.postsAPIDataManager = postsAPIDataManager
    }
    
    public func getPosts(fromCache: Bool,
                         completion: @escaping Completion<[Post], ServiceError>) {
        if fromCache {
            completion(.success(postsCacheDataManager.cachedPosts.allItems))
        } else {
            postsAPIDataManager.getAllPosts(
                completion: { [weak self] result in
                    switch result {
                    case .success(let users):
                        self?.postsCacheDataManager.cachedPosts.append(contentsOf: users)
                        completion(.success(users))
                    case .failure(let error):
                        completion(.failure(ServiceError(code: .getPosts, underlying: error)))
                    }
                }
            )
        }
    }
    
    public func getPost(id: UUID,
                        fromCache: Bool,
                        completion: @escaping Completion<Post, ServiceError>) {
        if let cachedPost = postsCacheDataManager.cachedPosts[id], fromCache {
            completion(.success(cachedPost))
        } else {
            postsAPIDataManager.getPost(
                id: id,
                completion: { [weak self] result in
                    switch result {
                    case .success(let post):
                        self?.postsCacheDataManager.cachedPosts.append(post)
                        completion(.success(post))
                    case .failure(let error):
                        completion(.failure(ServiceError(code: .getPost, underlying: error)))
                    }
                }
            )
        }
    }
}

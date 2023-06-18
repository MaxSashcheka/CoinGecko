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
                         success: @escaping Closure.PostsArray,
                         failure: @escaping Closure.ServiceError) {
        if fromCache {
            success(postsCacheDataManager.cachedPosts.allItems)
        } else {
            postsAPIDataManager.getAllPosts(
                success: { [weak self] in
                    self?.postsCacheDataManager.cachedPosts.append(contentsOf: $0)
                    success($0)
                },
                failure: ServiceError.wrap(failure, code: .getPosts)
            )
        }
    }
    
    public func getPost(id: UUID,
                        fromCache: Bool,
                        success: @escaping Closure.Post,
                        failure: @escaping Closure.ServiceError) {
        if let cachedPost = postsCacheDataManager.cachedPosts[id], fromCache {
            success(cachedPost)
        } else {
            postsAPIDataManager.getPost(
                id: id,
                success: { [weak self] in
                    self?.postsCacheDataManager.cachedPosts.append($0)
                    success($0)
                },
                failure: ServiceError.wrap(failure, code: .getPost)
            )
        }
    }
}

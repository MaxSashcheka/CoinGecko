//
//  ComposePostService.swift
//  Core
//
//  Created by Maksim Sashcheka on 23.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils
import UIKit.UIImage

public final class ComposePostService: ComposePostServiceProtocol {
    private let composePostCacheDataManager: ComposePostCacheDataManagerProtocol
    private let postsCacheDataManager: PostsCacheDataManagerProtocol
    private let postsAPIDataManager: PostsAPIDataManagerProtocol
    
    public init(composePostCacheDataManager: ComposePostCacheDataManagerProtocol,
                postsCacheDataManager: PostsCacheDataManagerProtocol,
                postsAPIDataManager: PostsAPIDataManagerProtocol) {
        self.composePostCacheDataManager = composePostCacheDataManager
        self.postsCacheDataManager = postsCacheDataManager
        self.postsAPIDataManager = postsAPIDataManager
    }
}

// MARK: - ComposePostService+ComputedProperties
public extension ComposePostService {
    var title: String? {
        get { composePostCacheDataManager.title }
        set { composePostCacheDataManager.title = newValue }
    }
    
    var content: String? {
        get { composePostCacheDataManager.content }
        set { composePostCacheDataManager.content = newValue }
    }
    
    var image: UIImage? {
        get { composePostCacheDataManager.image }
        set { composePostCacheDataManager.image = newValue }
    }
}

// MARK: - ComposePostService+Methods
public extension ComposePostService {
    func submitPost(imageURL: String,
                    completion: @escaping Completion<Void, ServiceError>) {
        guard let title = title, let content = content else {
            let appError = AppError(code: .unexpected, message: "Required fields should not be nil")
            completion(.failure(ServiceError(code: .createPost, underlying: appError)))
            return
        }
        
        postsAPIDataManager.createPost(
            title: title,
            content: content,
            authorId: UUID(),
            imageURL: imageURL,
            completion: { [weak self] result in
                switch result {
                case .success(let post):
                    self?.postsCacheDataManager.cachedPosts.addFront(post)
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(ServiceError(code: .createPost, underlying: error)))
                }
            }
        )
    }
}

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
                    success: @escaping Closure.Void,
                    failure: @escaping Closure.ServiceError) {
        guard let title = title, let content = content else {
            let appError = AppError(code: .unexpected, message: "Required fields should not be nil")
            failure(ServiceError(code: .createPost, underlying: appError))
            return
        }
        
        postsAPIDataManager.createPost(
            title: title,
            content: content,
            authorId: UUID(),
            imageURL: imageURL,
            success: { [weak self] in
                self?.postsCacheDataManager.cachedPosts.addFront($0)
                success()
            },
            failure: ServiceError.wrap(failure, code: .createPost)
        )
    }
}

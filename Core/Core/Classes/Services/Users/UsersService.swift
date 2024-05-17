//
//  UsersService.swift
//  Core
//
//  Created by Maksim Sashcheka on 25.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

public final class UsersService: UsersServiceProtocol {
    private let appPropertiesDataManager: AppPropertiesDataManager
    private let usersCacheDataManager: UsersCacheDataManagerProtocol
    private let usersAPIDataManager: UsersAPIDataManagerProtocol
    
    public var currentUser: User? {
        usersCacheDataManager.currentUser
    }
    
    public init(appPropertiesDataManager: AppPropertiesDataManager,
                usersCacheDataManager: UsersCacheDataManagerProtocol,
                usersAPIDataManager: UsersAPIDataManagerProtocol) {
        self.appPropertiesDataManager = appPropertiesDataManager
        self.usersCacheDataManager = usersCacheDataManager
        self.usersAPIDataManager = usersAPIDataManager
    }
    
    public func clearCurrentUser() {
        appPropertiesDataManager[.user] = nil as User?
        usersCacheDataManager.clearCurrentUser()
    }
    
    public func fetchUsers(fromCache: Bool = true,
                           completion: @escaping Completion<[User], ServiceError>) {
        if fromCache {
            completion(.success(usersCacheDataManager.cachedUsers.allItems))
            return
        }
        
        usersAPIDataManager.fetchAllUsers(
            completion: { [weak self] result in
                switch result {
                case .success(let users):
                    self?.usersCacheDataManager.cachedUsers.append(contentsOf: users)
                    completion(.success(users))
                case .failure(let error):
                    completion(.failure(ServiceError(code: .fetchUsers, underlying: error)))
                }
            }
        )
    }
    
    public func fetchUser(id: UUID,
                          fromCache: Bool = true,
                          completion: @escaping Completion<User, ServiceError>) {
        if fromCache, let cachedUser = usersCacheDataManager.cachedUsers[id] {
            completion(.success(cachedUser))
            return
        }
        
        usersAPIDataManager.fetchUser(
            id: id,
            completion: { [weak self] result in
                switch result {
                case .success(let users):
                    self?.usersCacheDataManager.cachedUsers.append(users)
                    completion(.success(users))
                case .failure(let error):
                    completion(.failure(ServiceError(code: .fetchUser, underlying: error)))
                }
            }
        )
    }
}

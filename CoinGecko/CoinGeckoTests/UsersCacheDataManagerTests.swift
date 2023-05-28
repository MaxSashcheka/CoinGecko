//
//  CoinGeckoTests.swift
//  CoinGeckoTests
//
//  Created by Maksim Sashcheka on 24.05.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import XCTest
@testable import Core
@testable import CoinGecko
@testable import Utils

final class UsersCacheDataManagerTests: XCTestCase {
    
    var sut: UsersCacheDataManager!

    override func setUpWithError() throws {
        self.sut = UsersCacheDataManager()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testAddUserToCache() throws {
        let userId = UUID()
        let user = User(id: userId, name: "name", login: "login", email: "email", role: .user)
        
        sut.cachedUsers.append(user)
        
        XCTAssertEqual(sut.cachedUsers.count, 1)
        XCTAssertEqual(sut.cachedUsers.allItems.first?.id, userId)
    }
    
    func testAddSameUserTwoTimes() {
        let user = User(id: UUID(), name: "name", login: "login", email: "email", role: .user)
        
        sut.cachedUsers.append(user)
        sut.cachedUsers.append(user)
        
        XCTAssertEqual(sut.cachedUsers.count, 1)
    }

    func testUpdateCurrentUser() {
        let userId = UUID()
        let user = User(id: userId, name: "name", login: "login", email: "email", role: .user)
        
        sut.updateCurrentUser(user)
        
        XCTAssertEqual(sut.currentUser?.id, userId)
        XCTAssertEqual(sut.cachedUsers.count, 1)
        XCTAssertEqual(sut.cachedUsers.allItems.first?.id, userId)
    }
    
    func testClearCurrentUser() {
        let userId = UUID()
        let user = User(id: userId, name: "name", login: "login", email: "email", role: .user)
        
        sut.updateCurrentUser(user)
        sut.clearCurrentUser()
        
        XCTAssertNil(sut.currentUser)
    }
}

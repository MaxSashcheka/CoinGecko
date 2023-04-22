//
//  AppAssembly.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 14.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Core

enum AppAssembly: Assembly { }

// MARK: - Coordinators

extension AppAssembly {
    static func appCoordinator() -> AppCoordinator {
        AppCoordinator(parent: nil)
    }
    
    static func trendingCoordinator(parent: Coordinator) -> TrendingCoordinator {
        TrendingCoordinator(parent: parent)
    }
    
    static func marketsCoordinator(parent: Coordinator) -> MarketsCoordinator {
        MarketsCoordinator(parent: parent)
    }
    
    
    
    static func homeCoordinator(parent: Coordinator) -> HomeCoordinator {
        HomeCoordinator(parent: parent)
    }
}

// MARK: - ExternalLinksBuilder

extension AppAssembly {
    static func externalLinkBuilder() -> ExternalLinkBuilder {
        // TODO: Move url to config
        ExternalLinkBuilder(webURL: "https://www.google.com")
    }
}

// MARK
extension ExternalLinkBuilder: DependencyResolvable { }


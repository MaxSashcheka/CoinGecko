//
//  RootAssembly.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 14.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Core
import Utils

final class RootAssembly: Assembly {
    static func makeRootCoordinator() -> RootCoordinator { RootCoordinator(parent: nil) }
}

// MARK: - Coordinators
extension RootAssembly {
    static func makeTrendingCoordinator(parent: Coordinator) -> TrendingCoordinator {
        TrendingCoordinator(parent: parent)
    }
    
    static func makeMarketsCoordinator(parent: Coordinator) -> MarketsCoordinator {
        MarketsCoordinator(parent: parent)
    }
    
    static func makeHomeCoordinator(parent: Coordinator) -> HomeCoordinator {
        HomeCoordinator(parent: parent)
    }
    
    static func makeExternalLinkBuilder() -> ExternalLinkBuilder {
        // TODO: Move url to config
        ExternalLinkBuilder(webURL: "https://www.google.com")
    }
}

// Resolvable
extension ExternalLinkBuilder: Resolvable { }


//
//  AppAssembly.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 14.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Core
import Utils

enum AppAssembly: Assembly { }

// MARK: - Coordinators

extension AppAssembly {
    static func appCoordinator() -> AppCoordinator {
        AppCoordinator(parent: nil)
    }
    
    static func trendingCoordinator(parent: TabCoordinator) -> TabContentCoordinator {
        TrendingCoordinator(parent: parent)
    }
    
    static func marketsCoordinator(parent: TabCoordinator) -> TabContentCoordinator {
        MarketsCoordinator(parent: parent)
    }
    
    static func newsCoordinator(parent: TabCoordinator) -> TabContentCoordinator {
        NewsCoordinator(parent: parent)
    }
    
    static func homeCoordinator(parent: TabCoordinator) -> TabContentCoordinator {
        HomeCoordinator(parent: parent)
    }
}

// MARK: - Handlers

extension AppAssembly {
    private enum Handlers {
        static let alerts = AppAlertCoordinator()
        static let activityIndicator = ActivityIndicatorCoordinator()
        static let events = EventsTracker()
        static let errors = ErrorsHandler(alertsHandler: alerts, tracker: events)
    }
    
    static func alertsPresenter() -> AppAlertCoordinator { Handlers.alerts }
    static func activityIndicator() -> ActivityIndicatorCoordinator { Handlers.activityIndicator }
    static func errorsHandler() -> ErrorsHandler { Handlers.errors }
}

// MARK: - ExternalLinksBuilder

extension AppAssembly {
    static func externalLinkBuilder() -> ExternalLinkBuilder {
        // TODO: Move url to config
        ExternalLinkBuilder(webURL: "https://www.google.com")
    }
}

extension ExternalLinkBuilder: DependencyResolvable { }

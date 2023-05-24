//
//  HandlersAccessingProtocol.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 4.05.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Foundation

protocol HandlersAccessible {
    var alertHandler: AppAlertCoordinator { get }
    var activityIndicator: ActivityIndicatorCoordinator { get }
}

extension HandlersAccessible {
    var alertHandler: AppAlertCoordinator { AppAssembly.alertsPresenter() }
    var activityIndicator: ActivityIndicatorCoordinator { AppAssembly.activityIndicator() }
}

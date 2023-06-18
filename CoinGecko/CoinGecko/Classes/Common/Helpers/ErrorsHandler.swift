//
//  ErrorsHandler.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 17.06.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

final class ErrorsHandler {
    private let alertsHandler: AppAlertCoordinator
    private let tracker: ErrorsTrackerProtocol
    
    init(alertsHandler: AppAlertCoordinator, tracker: ErrorsTrackerProtocol) {
        self.alertsHandler = alertsHandler
        self.tracker = tracker
    }
    
    var handleClosure: Closure.AnyError {
        handleClosure(completion: nil)
    }
    
    func handleClosure(completion: Closure.Void?) -> Closure.AnyError {
        { [weak self] error in
            self?.handle(error: error, completion: completion)
        }
    }
    
    func handle(error: AnyError, completion: Closure.Void?) {
        alertsHandler.showAlert(error, completion: completion)
        tracker.track(error: error)
    }
}

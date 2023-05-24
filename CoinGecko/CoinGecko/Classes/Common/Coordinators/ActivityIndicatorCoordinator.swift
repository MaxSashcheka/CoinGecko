//
//  ActivityIndicatorCoordinator.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 9.05.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

class ActivityIndicatorCoordinator {
    var indicatorControllers: [ActivityIndicatorController] = []
    
    func show() {
        let indicatorController = ActivityIndicatorController()
        indicatorControllers.append(indicatorController)
        indicatorController.show()
    }
    
    func hide() {
        indicatorControllers.popLast()?.hide()
    }
}

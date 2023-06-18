//
//  ActivityIndicatorCoordinator.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 9.05.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

class ActivityIndicatorCoordinator {
    private var indicatorControllers: [ActivityIndicatorController] = []
    
    func show() {
        let indicatorController = ActivityIndicatorController()
        indicatorControllers.append(indicatorController)
        indicatorController.show()
    }
    
    var hideClosure: Closure.Void {
        { [weak self] in self?.hide() }
    }
    
    func hide() {
        indicatorControllers.popLast()?.hide()
    }
}

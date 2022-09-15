//
//  RootCoordinator.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 14.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import UIKit
import Utils

final class RootCoordinator: ContainerCoordinator {

    override func registerContent() {
        
    }

    func start(at window: UIWindow?) {
        assert(window != nil, "Root Window is nil")
        window?.rootViewController = baseViewController
        window?.makeKeyAndVisible()

        initializeHomeCoordinatorAndShow()
    }
}

private extension RootCoordinator {
    func initializeHomeCoordinatorAndShow() {
        let coordinator = HomeCoordinator(parent: self)
        setContentCoordinator(coordinator)
    }
}

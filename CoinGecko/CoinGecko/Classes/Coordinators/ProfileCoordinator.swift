//
//  ProfileCoordinator.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 10.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Core
import Utils

final class ProfileCoordinator: NavigationCoordinator {
    override init(parent: Coordinator?) {
        super.init(parent: parent)
        
        showProfileScreen()
    }
}

extension ProfileCoordinator {
    func showProfileScreen() {
        let (viewController, viewModel) = ProfileAssembly.makeProfileScreen(resolver: self)
        viewModel.openSettingsTransition = { [weak self] in
            
        }
        
        pushViewController(viewController, animated: false)
    }
}

//
//  ProfileAssembly.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 10.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Utils

final class ProfileAssembly { }

// MARK: - Screens
extension ProfileAssembly {
    typealias ProfileViewModel = ProfileViewController.ViewModel
    static func makeProfileScreen(resolver: Resolver) -> (ProfileViewController, ProfileViewModel) {
        let viewController = ProfileViewController()
        let viewModel = ProfileViewModel()
        viewController.viewModel = viewModel
        
        return (viewController, viewModel)
    }
}

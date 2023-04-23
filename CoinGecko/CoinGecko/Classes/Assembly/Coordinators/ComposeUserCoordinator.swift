//
//  ComposeUserCoordinator.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 16.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Core
import Utils

final class ComposeUserCoordinator: NavigationCoordinator {
    struct Transitions {
        let close: Transition
    }
    
    private let transitions: Transitions
    
    init(parent: Coordinator?, transitions: Transitions) {
        self.transitions = transitions
        
        super.init(parent: parent)
        
        showComposeUserInfoScreen()
    }
    
    override func registerContent() {
        register(SessionsAssembly.composeUserCacheDataManager(resolver: self))
    }
}

extension ComposeUserCoordinator {
    func showComposeUserInfoScreen() {
        let transitions = ComposeUserInfoViewController.ViewModel.Transitions(
            close: { [weak self] in self?.transitions.close() },
            composeUserPhoto: { [weak self] in self?.showComposeUserPhotoInfoScreen() }
        )
        let screen = ComposeUserAssembly.composeUserInfoScreen(
            transitions: transitions,
            resolver: self
        )
        pushViewController(screen, animated: false)
    }
    
    func showComposeUserPhotoInfoScreen() {
        let transitions = ComposeUserPhotoViewModel.Transitions(
            close: { [weak self] in self?.transitions.close() },
            completion: { [weak self] in self?.transitions.close() },
            pickImage: showImagePickerScreenTransition
        )
        let screen = ComposeUserAssembly.composeUserPhotoScreen(
            transitions: transitions,
            resolver: self
        )
        pushViewController(screen)
    }
}

// MARK: - ComposeUserCoordinator+ImagePickerPresentable
extension ComposeUserCoordinator: ImagePickerPresentable { }

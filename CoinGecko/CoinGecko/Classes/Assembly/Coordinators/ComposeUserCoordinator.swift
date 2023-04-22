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
        let transitions = ComposeUserPhotoViewController.ViewModel.Transitions(
            close: { [weak self] in self?.transitions.close() },
            pickImage: { [weak self] completion in
                self?.showImagePickerScreen(completion: { image in
                    completion(image)
                    self?.dismissModalController()
                })
            }
        )
        let screen = ComposeUserAssembly.composeUserPhotoScreen(
            transitions: transitions,
            resolver: self
        )
        pushViewController(screen)
    }
    
    func showImagePickerScreen(completion: @escaping Closure.UIImage) {
        let transitions = ImagePickerViewController.ViewModel.Transitions(
            close: { [weak self] in self?.dismissModalController() },
            completion: completion
        )
        let screen = CommonAssembly.imagePickerScreen(transitions: transitions)
        presentModal(controller: screen)
    }
}

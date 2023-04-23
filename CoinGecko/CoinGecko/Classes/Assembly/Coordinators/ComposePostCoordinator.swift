//
//  ComposePostCoordinator.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 23.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Core
import Utils

final class ComposePostCoordinator: NavigationCoordinator {
    struct Transitions {
        let close: Transition
    }
    
    private let transitions: Transitions
    private let completionClosure: Closure.Void
    
    init(parent: Coordinator?,
         transitions: Transitions,
         completion: @escaping Closure.Void) {
        self.transitions = transitions
        self.completionClosure = completion
        
        super.init(parent: parent)
        
        showComposePostInfoScreen()
    }
    
    override func registerContent() {
        register(SessionsAssembly.composePostCacheDataManager(resolver: self))
    }
}

extension ComposePostCoordinator {
    func showComposePostInfoScreen() {
        let transitions = ComposePostInfoViewController.ViewModel.Transitions(
            close: { [weak self] in self?.transitions.close() },
            composePostPhoto: { [weak self] in self?.showComposePostPhotoInfoScreen() }
        )
        let screen = ComposePostAssembly.composePostInfoScreen(
            transitions: transitions,
            resolver: self
        )
        pushViewController(screen, animated: false)
    }
    
    func showComposePostPhotoInfoScreen() {
        let transitions = ComposePostPhotoViewModel.Transitions(
            close: { [weak self] in self?.transitions.close() },
            completion: { [weak self] in
                self?.completionClosure()
                self?.transitions.close()
            },
            pickImage: showImagePickerScreenTransition
        )
        let screen = ComposePostAssembly.composePostPhotoScreen(
            transitions: transitions,
            resolver: self
        )
        pushViewController(screen)
    }
}

// MARK: - ComposePostCoordinator+ImagePickerPresentable
extension ComposePostCoordinator: ImagePickerPresentable { }

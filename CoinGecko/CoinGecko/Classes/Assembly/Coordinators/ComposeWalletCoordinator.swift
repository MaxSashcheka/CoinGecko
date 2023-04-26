//
//  ComposeWalletCoordinator.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 26.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Core
import Utils

final class ComposeWalletCoordinator: NavigationCoordinator {
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
        
        showComposeWalletScreen()
    }
}

extension ComposeWalletCoordinator {
    func showComposeWalletScreen() {
        let transitions = ComposeWalletViewController.ViewModel.Transitions(
            close: { [weak self] in self?.transitions.close() },
            completion: { [weak self] in
                self?.completionClosure()
                self?.transitions.close()
            },
            pickColor: { [weak self] in self?.showColorPickerScreen(completion: $0) }
        )
        let screen = ComposeWalletAssembly.composeWalletScreen(
            transitions: transitions,
            resolver: self
        )
        pushViewController(screen, animated: false)
    }
    
    func showColorPickerScreen(completion: @escaping Closure.UIColor) {
        let transitions = ColorPickerViewController.ViewModel.Transitions(
            close: { [weak self] in self?.clearUnusedModalController() },
            completion: completion
        )
        let screen = ComposeWalletAssembly.colorPickerScreen(
            transitions: transitions,
            resolver: self
        )
        presentModal(controller: screen)
    }
}

//
//  ComposeUserPhotoViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 16.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import Core
import UIKit.UIImage
import Utils

extension ComposeUserPhotoViewController {
    final class ViewModel: ErrorHandableViewModel, ScreenTransitionable {
        private let services: Services
        let transitions: Transitions
        
        let selectedImage = CurrentValueSubject<UIImage?, Never>(nil)
        
        init(transitions: Transitions, services: Services) {
            self.transitions = transitions
            self.services = services

            super.init()
        }
    }
}

// MARK: - ComposeUserPhotoViewModel+NestedTypes
extension ComposeUserPhotoViewController.ViewModel {
    struct Transitions: ScreenTransitions {
        let close: Closure.Void
        let pickImage: (@escaping Closure.UIImage) -> Void
    }
    
    final class Services {
        let composeUser: ComposeUserServiceProtocol
        
        init(composeUser: ComposeUserServiceProtocol) {
            self.composeUser = composeUser
        }
    }
}

extension ComposeUserPhotoViewController.ViewModel {
    func didTapCloseButton() {
        transitions.close()
    }
    
    func didTapPickPhotoButton() {
        transitions.pickImage { [weak self] image in
            self?.selectedImage.send(image)
        }
    }
    
    func didTapFinishButton() {
        transitions.close()
    }
}

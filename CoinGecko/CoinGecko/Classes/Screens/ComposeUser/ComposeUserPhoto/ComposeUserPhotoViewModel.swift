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
        let firebaseProvider: FirebaseProvider
        
        init(composeUser: ComposeUserServiceProtocol,
             firebaseProvider: FirebaseProvider) {
            self.composeUser = composeUser
            self.firebaseProvider = firebaseProvider
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
            self?.services.composeUser.image = image
        }
    }
    
    func didTapFinishButton() {
        guard let image = services.composeUser.image else { return }
        ActivityIndicator.show()
        services.firebaseProvider.uploadImage(
            image: image,
            success: { [weak self] imageURL in
                self?.services.composeUser.submitUser(
                    imageURL: imageURL,
                    success: { [weak self] in
                        ActivityIndicator.hide()
                        self?.transitions.close()
                    },
                    failure: { [weak self] error in
                        ActivityIndicator.hide()
                        self?.errorHandlerClosure(error)
                    }
                )
            },
            failure: { [weak self] error in
                self?.errorHandlerClosure(error)
                ActivityIndicator.hide()
            })
    }
}

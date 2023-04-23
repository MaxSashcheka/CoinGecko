//
//  BaseComposePhotoViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 22.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import Core
import UIKit.UIImage
import Utils

class BaseComposePhotoViewModel: ErrorHandableViewModel, ScreenTransitionable {
    private let services: BaseServices
    let transitions: Transitions
    
    let selectedImage = CurrentValueSubject<UIImage?, Never>(nil)
    
    init(transitions: Transitions, services: BaseServices) {
        self.transitions = transitions
        self.services = services

        super.init()
    }
    
    func handleFinishImageUpload(imageURL: String) {
        // Method should be overridden in subclasses
    }
    
    func saveImage(_ image: UIImage) {
        // Method should be overridden in subclasses
    }
}

// MARK: - BaseComposePhotoViewModel+NestedTypes
extension BaseComposePhotoViewModel {
    struct Transitions: ScreenTransitions {
        let close: Transition
        let completion: Transition
        let pickImage: (@escaping Closure.UIImage) -> Void
    }
    
    class BaseServices {
        let firebaseProvider: FirebaseProvider
        
        init(firebaseProvider: FirebaseProvider) {
            self.firebaseProvider = firebaseProvider
        }
    }
}

// MARK: - BaseComposePhotoViewModel+TapActions
extension BaseComposePhotoViewModel {
    func didTapCloseButton() {
        transitions.close()
    }
    
    func didTapPickPhotoButton() {
        transitions.pickImage { [weak self] in
            self?.selectedImage.send($0)
            self?.saveImage($0)
        }
    }
    
    func didTapFinishButton() {
        guard let image = selectedImage.value else { return }
        ActivityIndicator.show()
        services.firebaseProvider.uploadImage(
            image: image,
            success: { [weak self] in
                self?.handleFinishImageUpload(imageURL: $0)
            },
            failure: { [weak self] in
                self?.errorHandlerClosure($0)
                ActivityIndicator.hide()
            }
        )
    }
}

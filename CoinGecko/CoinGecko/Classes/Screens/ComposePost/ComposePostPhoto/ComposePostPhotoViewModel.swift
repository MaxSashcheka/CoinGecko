//
//  ComposePostPhotoViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 23.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import Core
import UIKit.UIImage
import Utils

class ComposePostPhotoViewModel: BaseComposePhotoViewModel {
    private let services: ComposePostServices
    
    init(transitions: Transitions, services: ComposePostServices) {
        self.services = services

        super.init(transitions: transitions, services: services)
    }
    
    override func handleFinishImageUpload(imageURL: String) {
        services.composePost.submitPost(
            imageURL: imageURL,
            completion: { [weak self] result in
                switch result {
                case .success(_):
                    self?.activityIndicator.hide()
                    self?.transitions.completion()
                case .failure(let error):
                    self?.errorsHandler.handle(error: error, completion: self?.activityIndicator.hideClosure)
                }
            }
        )
    }
    
    override func saveImage(_ image: UIImage) {
        services.composePost.image = image
    }
}

extension ComposePostPhotoViewModel {
    final class ComposePostServices: BaseServices {
        let composePost: ComposePostServiceProtocol
        
        init(composePost: ComposePostServiceProtocol,
             firebaseProvider: FirebaseProvider) {
            self.composePost = composePost
            
            super.init(firebaseProvider: firebaseProvider)
        }
    }
}

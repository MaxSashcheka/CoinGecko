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

class ComposeUserPhotoViewModel: BaseComposePhotoViewModel {
    private let services: ComposeUserServices
    
    init(transitions: Transitions, services: ComposeUserServices) {
        self.services = services

        super.init(transitions: transitions, services: services)
    }
    
    override func handleFinishImageUpload(imageURL: String) {
        services.composeUser.submitUser(
            imageURL: imageURL,
            success: { [weak self] in
                self?.activityIndicator.hide()
                self?.transitions.completion()
            },
            failure: errorsHandler.handleClosure(completion: activityIndicator.hideClosure)
        )
    }
    
    override func saveImage(_ image: UIImage) {
        services.composeUser.image = image
    }
}

extension ComposeUserPhotoViewModel {
    final class ComposeUserServices: BaseServices {
        let composeUser: ComposeUserServiceProtocol
        
        init(composeUser: ComposeUserServiceProtocol,
             firebaseProvider: FirebaseProvider) {
            self.composeUser = composeUser
            
            super.init(firebaseProvider: firebaseProvider)
        }
    }
}

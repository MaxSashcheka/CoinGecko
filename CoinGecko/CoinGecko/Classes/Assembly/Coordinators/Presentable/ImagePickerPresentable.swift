//
//  ImagePickerPresentable.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 23.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

protocol ImagePickerPresentable {
    func showImagePickerScreen(completion: @escaping Closure.UIImage)
}

extension ImagePickerPresentable where Self: NavigationCoordinator {
    func showImagePickerScreen(completion: @escaping Closure.UIImage) {
        let transitions = ImagePickerViewController.ViewModel.Transitions(
            close: { [weak self] in self?.dismissModalController() },
            completion: completion
        )
        let screen = CommonAssembly.imagePickerScreen(transitions: transitions)
        presentModal(controller: screen)
    }
    
    var showImagePickerScreenTransition: (@escaping Closure.UIImage) -> Void {
        { [weak self] completion in
            self?.showImagePickerScreen(completion: { image in
                completion(image)
                self?.dismissModalController()
            })
        }
    }
}

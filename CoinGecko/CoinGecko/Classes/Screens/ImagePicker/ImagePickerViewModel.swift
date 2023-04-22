//
//  ImagePickerViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 17.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import UIKit.UIImage
import Utils

extension ImagePickerViewController {
    final class ViewModel: ScreenTransitionable {
        let transitions: Transitions
        
        init(transitions: Transitions) {
            self.transitions = transitions
        }
        
        func didFinishPickingImage(_ image: UIImage) {
            transitions.completion(image)
        }
    }
}

extension ImagePickerViewController.ViewModel {
    struct Transitions: ScreenTransitions {
        let close: Closure.Void
        let completion: Closure.UIImage
    }
}

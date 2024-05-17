//
//  ColorPickerViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 26.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import Utils
import UIKit.UIColor

extension ColorPickerViewController {
    final class ViewModel: ScreenTransitionable {
        let transitions: Transitions
        
        init(transitions: Transitions) {
            self.transitions = transitions
        }
        
        func didPickColor(_ color: UIColor) {
            transitions.completion(color)
            transitions.close()
        }
    }
}

extension ColorPickerViewController.ViewModel {
    struct Transitions: ScreenTransitions {
        let close: Transition
        let completion: Closure.UIColor
    }
}

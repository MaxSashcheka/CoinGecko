//
//  ComposePostInfoViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 22.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import Core
import SnapKit
import Utils

extension ComposePostInfoViewController {
    final class ViewModel: ErrorHandableViewModel, ScreenTransitionable {
        private typealias Texts = L10n.CreatePost
        
        private let services: Services
        let transitions: Transitions
        
        let contentText = CurrentValueSubject<String, Never>(.empty)
        let isContentErrorVisible = CurrentValueSubject<Bool, Never>(false)
        
        let titleTextFieldViewModel = TitledTextField.ViewModel(
            title: Texts.TitleTextField.title,
            errorHintText: Texts.TitleTextField.hint
        )
        
        init(transitions: Transitions, services: Services) {
            self.transitions = transitions
            self.services = services

            super.init()
            
            titleTextFieldViewModel.saveTextClosure = { [weak self] in
                self?.services.composePost.title = $0
            }
        }
        
        func saveContent(_ value: String) {
            services.composePost.content = value
        }
    }
}

// MARK: - ComposePostInfoViewModel+NestedTypes
extension ComposePostInfoViewController.ViewModel {
    struct Transitions: ScreenTransitions {
        let close: Transition
        let composePostPhoto: Transition
    }
    
    final class Services {
        let composePost: ComposePostServiceProtocol
        
        init(composePost: ComposePostServiceProtocol) {
            self.composePost = composePost
        }
    }
}

// MARK: - ComposePostInfoViewModel+TapActions
extension ComposePostInfoViewController.ViewModel {
    func didTapCloseButton() {
        transitions.close()
    }
    
    func didTapContinueButton() {
        titleTextFieldViewModel.isErrorVisible.send(
            titleTextFieldViewModel.text.value.isEmpty
        )
        isContentErrorVisible.send(contentText.value.isEmpty)
        
        guard !titleTextFieldViewModel.isErrorVisible.value,
              !isContentErrorVisible.value else { return }
        
        transitions.composePostPhoto()
    }
}

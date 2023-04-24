//
//  SignInViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 24.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import Core
import Utils

extension SignInViewController {
    final class ViewModel: ErrorHandableViewModel, ScreenTransitionable {
        private let services: Services
        let transitions: Transitions
        
        let loginTitledTextFieldViewModel = TitledTextField.ViewModel(
            title: "Write login",
            errorHintText: "Login should not be empty"
        )
        
        let passwordTitledTextFieldViewModel = TitledTextField.ViewModel(
            title: "Write password",
            errorHintText: "Password should not be empty",
            isSecureTextEntry: true
        )
        
        var textFieldsViewModels: [TitledTextField.ViewModel] {
            [loginTitledTextFieldViewModel, passwordTitledTextFieldViewModel]
        }
        
        init(transitions: Transitions, services: Services) {
            self.transitions = transitions
            self.services = services

            super.init()
        }
    }
}

// MARK: - SignInViewModel+NestedTypes
extension SignInViewController.ViewModel {
    struct Transitions: ScreenTransitions {
        let close: Closure.Void
        let completion: Closure.Void
    }
    
    final class Services {
        let auth: AuthServiceProtocol
        
        init(auth: AuthServiceProtocol) {
            self.auth = auth
        }
    }
}

// MARK: - SignInViewModel+TapActions
extension SignInViewController.ViewModel {
    func didTapCloseButton() {
        transitions.close()
    }
    
    func didTapLoginButton() {
        textFieldsViewModels.forEach {
            $0.isErrorVisible.send(false)
        }
        
        if loginTitledTextFieldViewModel.text.value.isEmpty {
            loginTitledTextFieldViewModel.isErrorVisible.send(true)
        }
        
        if passwordTitledTextFieldViewModel.text.value.isEmpty {
            passwordTitledTextFieldViewModel.isErrorVisible.send(true)
        }
        
        guard !textFieldsViewModels.contains(where: { $0.isErrorVisible.value }) else { return }
        services.auth.login(
            login: loginTitledTextFieldViewModel.text.value,
            password: passwordTitledTextFieldViewModel.text.value,
            success: { [weak self] in self?.transitions.completion() },
            failure: { [weak self] in self?.errorHandlerClosure($0) }
        )
    }
}

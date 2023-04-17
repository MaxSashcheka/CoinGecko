//
//  ComposeUserInfoViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 16.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import Core
import Utils

extension ComposeUserInfoViewController {
    final class ViewModel: ErrorHandableViewModel, ScreenTransitionable {
        private let services: Services
        let transitions: Transitions
        
        let usernameTitledTextFieldViewModel = TitledTextField.ViewModel(
            title: "Write username",
            errorHintText: "Username should not be empty"
        )
        
        let loginTitledTextFieldViewModel = TitledTextField.ViewModel(
            title: "Write login",
            errorHintText: "Login should not be empty"
        )
        
        let passwordTitledTextFieldViewModel = TitledTextField.ViewModel(
            title: "Write password",
            errorHintText: "Password should not be empty",
            isSecureTextEntry: true
        )
        
        let emailTitledTextFieldViewModel = TitledTextField.ViewModel(
            title: "Write email",
            errorHintText: "Email should not be empty"
        )
        
        let showPersonalWebPageOptionPickerViewModel = OptionPickerView.ViewModel(
            title: "Do your want to add\npersonal web page link?"
        )
        
        let personalWebPageTitledTextFieldViewModel = TitledTextField.ViewModel(
            title: "Paste Your personal web page url",
            errorHintText: "Web page url should not be empty"
        )
        
        var textFieldViewModels: [TitledTextField.ViewModel] {[
            usernameTitledTextFieldViewModel, loginTitledTextFieldViewModel,
            passwordTitledTextFieldViewModel, passwordTitledTextFieldViewModel,
            emailTitledTextFieldViewModel, personalWebPageTitledTextFieldViewModel
        ]}
        
        init(transitions: Transitions, services: Services) {
            self.transitions = transitions
            self.services = services

            super.init()
            
            usernameTitledTextFieldViewModel.saveTextClosure = { [weak self] _ in
                print("usernameTitledTextFieldViewModel saveTextClosure")
            }
            
            loginTitledTextFieldViewModel.saveTextClosure = { [weak self] _ in
                print("loginTitledTextFieldViewModel saveTextClosure")
            }
            
            passwordTitledTextFieldViewModel.saveTextClosure = { [weak self] _ in
                print("passwordTitledTextFieldViewModel saveTextClosure")
            }
            
            emailTitledTextFieldViewModel.saveTextClosure = { [weak self] _ in
                print("emailTitledTextFieldViewModel saveTextClosure")
            }
            
            personalWebPageTitledTextFieldViewModel.saveTextClosure = { [weak self] _ in
                print("personalWebPageTitledTextFieldViewModel saveTextClosure")
            }
        
        }
    }
}

// MARK: - ComposeUserInfoViewModel+NestedTypes
extension ComposeUserInfoViewController.ViewModel {
    struct Transitions: ScreenTransitions {
        let close: Closure.Void
        let composeUserPhoto: Closure.Void
    }
    
    final class Services {
//        let coins: CoinsServiceProtocol
//
//        init(coins: CoinsServiceProtocol) {
//            self.coins = coins
//        }
    }
}

extension ComposeUserInfoViewController.ViewModel {
    func didTapCloseButton() {
        transitions.close()
    }
    
    func didTapShowComposeUserPhotoButton() {
        textFieldViewModels.forEach { $0.isErrorVisible.send(false) }
        
        if usernameTitledTextFieldViewModel.text.value.isEmpty {
            usernameTitledTextFieldViewModel.isErrorVisible.send(true)
        }
        
        if loginTitledTextFieldViewModel.text.value.isEmpty {
            loginTitledTextFieldViewModel.isErrorVisible.send(true)
        }
        
        if passwordTitledTextFieldViewModel.text.value.isEmpty {
            passwordTitledTextFieldViewModel.isErrorVisible.send(true)
        }
        
        if !emailTitledTextFieldViewModel.text.value.isValidEmail {
            emailTitledTextFieldViewModel.isErrorVisible.send(true)
            emailTitledTextFieldViewModel.errorHintText.send("Incorrect email format")
        }
        
        if emailTitledTextFieldViewModel.text.value.isEmpty {
            emailTitledTextFieldViewModel.isErrorVisible.send(true)
            emailTitledTextFieldViewModel.errorHintText.send("Email should not be empty")
        }
        
        if showPersonalWebPageOptionPickerViewModel.selectedOption.value {
            if !personalWebPageTitledTextFieldViewModel.text.value.isValidURL {
                personalWebPageTitledTextFieldViewModel.isErrorVisible.send(true)
                personalWebPageTitledTextFieldViewModel.errorHintText.send("Web page url is incorrect")
            }
            if personalWebPageTitledTextFieldViewModel.text.value.isEmpty {
                personalWebPageTitledTextFieldViewModel.isErrorVisible.send(true)
                personalWebPageTitledTextFieldViewModel.errorHintText.send("Web page url should not be empty")
            }
        }
        
        guard !textFieldViewModels.contains(where: { $0.isErrorVisible.value }) else { return }
        transitions.composeUserPhoto()
    }
}

fileprivate extension String {
    var isValidEmail: Bool {
        guard let regex = try? NSRegularExpression(
            pattern: "(?!.*\\.\\.)[^\\.][A-Z0-9a-z._%+-]*@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$",
            options: .caseInsensitive
        ) else { return false }
        return !regex.firstMatch(
            in: self,
            options: [],
            range: NSRange(location: .zero, length: count)
        ).isNil
    }
}

extension String {
    var isValidURL: Bool {
        guard let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else { return false}
        guard let match = detector.firstMatch(
            in: self,
            options: [],
            range: NSRange(location: .zero, length: utf16.count)
        ) else { return false }
        return match.range.length == utf16.count
    }
}

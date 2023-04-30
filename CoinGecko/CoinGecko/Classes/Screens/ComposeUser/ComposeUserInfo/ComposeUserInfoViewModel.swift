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
        private typealias Texts = L10n.CreateUser
        
        private let services: Services
        let transitions: Transitions
        
        let usernameTitledTextFieldViewModel = TitledTextField.ViewModel(
            title: Texts.Username.title,
            errorHintText: Texts.Username.hint
        )
        
        let loginTitledTextFieldViewModel = TitledTextField.ViewModel(
            title: Texts.Login.title,
            errorHintText: Texts.Login.hint
        )
        
        let passwordTitledTextFieldViewModel = TitledTextField.ViewModel(
            title: Texts.Password.title,
            errorHintText: Texts.Password.hint,
            isSecureTextEntry: true
        )
        
        let emailTitledTextFieldViewModel = TitledTextField.ViewModel(
            title: Texts.Email.title,
            errorHintText: Texts.Email.hint
        )
        
        let showPersonalWebPageOptionPickerViewModel = OptionPickerView.ViewModel(
            title: Texts.PersonalWebPage.optionTitle
        )
        
        let personalWebPageTitledTextFieldViewModel = TitledTextField.ViewModel(
            title: Texts.PersonalWebPage.title,
            errorHintText: Texts.PersonalWebPage.hint
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
            
            setupTextFieldsViewModels()
        }
    }
}

private extension ComposeUserInfoViewController.ViewModel {
    func setupTextFieldsViewModels() {
        usernameTitledTextFieldViewModel.saveTextClosure = { [weak self] in
            self?.services.composeUser.username = $0
        }
        
        loginTitledTextFieldViewModel.saveTextClosure = { [weak self] in
            self?.services.composeUser.login = $0
        }
        
        passwordTitledTextFieldViewModel.saveTextClosure = { [weak self] in
            self?.services.composeUser.password = $0
        }
        
        emailTitledTextFieldViewModel.saveTextClosure = { [weak self] in
            self?.services.composeUser.email = $0
        }
        
        personalWebPageTitledTextFieldViewModel.saveTextClosure = { [weak self] in
            self?.services.composeUser.personalWebLink = $0
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
        let composeUser: ComposeUserServiceProtocol
        
        init(composeUser: ComposeUserServiceProtocol) {
            self.composeUser = composeUser
        }
    }
    
    enum UserRole: Int, CaseIterable {
        case user
        case admin
        
        var title: String {
            switch self {
            case .user: return "User"
            case .admin: return "Admin"
            }
        }
    }
}

extension ComposeUserInfoViewController.ViewModel {
    func didTapCloseButton() {
        transitions.close()
    }
    
    func didTapShowComposeUserPhotoButton(userRole: UserRole) {
        services.composeUser.role = userRole.title
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

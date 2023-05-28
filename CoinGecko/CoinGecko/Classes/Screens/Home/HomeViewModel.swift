//
//  HomeViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 10.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import Core
import Utils

extension HomeViewController {
    final class ViewModel: ErrorHandableViewModel, ScreenTransitionable, PriceConvertable {
        private typealias Texts = L10n.Home.TableRow
        typealias ProfileCellViewModel = ProfileTableCell.ViewModel
        
        let placeholderViewModel = HomeViewController.SignInPlaceholderView.ViewModel()
        
        let cellsViewModels = CurrentValueSubject<[[BaseProfileTableCellViewModel]], Never>([])
        let profileImageURL = CurrentValueSubject<URL?, Never>(nil)
        let isTableVisible = CurrentValueSubject<Bool, Never>(false)
        
        private let services: Services
        let transitions: Transitions
        
        init(transitions: Transitions, services: Services) {
            self.transitions = transitions
            self.services = services
            
            super.init()
            
            fetchCurrentUserData()
        }
    }
}

// MARK: - HomeViewModel+NestedTypes
extension HomeViewController.ViewModel {
    struct Transitions: ScreenTransitions {
        let signIn: (@escaping Closure.Void) -> Void
        let signUp: (@escaping Closure.Void) -> Void
        let personalWebPage: Closure.URL
        let accountWallets: Transition
        let usersList: Transition
    }
    
    final class Services {
        let auth: AuthServiceProtocol
        let users: UsersServiceProtocol
        
        init(auth: AuthServiceProtocol,
             users: UsersServiceProtocol) {
            self.auth = auth
            self.users = users
        }
    }
}

// MARK: - HomeViewModel+TableViewDataProviders
extension HomeViewController.ViewModel {
    var numberOfSections: Int { cellsViewModels.value.count }
    
    func numberOfItems(for section: Int) -> Int {
        cellsViewModels.value[section].count
    }
    
    func cellViewModel(for indexPath: IndexPath) -> BaseProfileTableCellViewModel {
        cellsViewModels.value[indexPath.section][indexPath.row]
    }
    
    func selectRow(at indexPath: IndexPath) {
        cellViewModel(for: indexPath).selectClosure?()
    }
}

// MARK: - HomeViewModel+Private
private extension HomeViewController.ViewModel {
    func fetchCurrentUserData() {
        guard let user = services.users.currentUser else {
            isTableVisible.send(false)
            return
        }
        isTableVisible.send(true)
        profileImageURL.send(user.imageURL)
        setupData(with: user)
    }
    
    func setupData(with user: User) {
        var infoViewModels = [[BaseProfileTableCellViewModel]]()
        infoViewModels.append([
            ProfileCellViewModel(title: Texts.id, description: String(user.id.uuidString.prefix(8))),
            ProfileCellViewModel(title: Texts.username, description: user.name),
            ProfileCellViewModel(title: Texts.login, description: user.login),
            ProfileCellViewModel(title: Texts.email, description: user.email),
            ProfileCellViewModel(title: Texts.userRole, description: user.role.rawValue, isSeparatorLineHidden: true)
        ])
        
        infoViewModels.append([
            ProfileCellViewModel(
                title: Texts.wallets,
                description: .empty,
                isSeparatorLineHidden: true,
                type: .action,
                selectClosure: { [weak self] in self?.transitions.accountWallets() }
            )
        ])
        
        if !user.webPageURL.isNil {
            infoViewModels.append([
                ProfileCellViewModel(
                    title: Texts.personalWebPage,
                    description: .empty,
                    isSeparatorLineHidden: true,
                    type: .action,
                    selectClosure: { [weak self] in
                        guard let url = user.webPageURL else { return }
                        self?.transitions.personalWebPage(url)
                    }
                )
            ])
        }
        
        if user.role == .user {
            infoViewModels.append([
                ProfileCellViewModel(
                    title: "Список пользователей",
                    description: .empty,
                    isSeparatorLineHidden: true,
                    type: .action,
                    selectClosure: { [weak self] in self?.transitions.usersList() }
                )
            ])
        }
        
        infoViewModels.append([
            HomeViewController.ActionTableCell.ViewModel(
                title: Texts.logOut,
                selectClosure: { [weak self] in
                    self?.services.users.clearCurrentUser()
                    self?.fetchCurrentUserData()
                }
            )
        ])
        
        cellsViewModels.send(infoViewModels)
    }
}

// MARK: - HomeViewModel+TapActions
extension HomeViewController.ViewModel {
    var signInClosure: Closure.Void {
        { [weak self] in self?.fetchCurrentUserData() }
    }
    
    func didTapSignInButton() {
        transitions.signIn(signInClosure)
    }
    
    func didTapSignUpButton() {
        transitions.signUp(signInClosure)
    }
}

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
        typealias ProfileCellViewModel = HomeViewController.ProfileTableCell.ViewModel
        private typealias Texts = L10n.Home.NetworthCard.Status
        
        let placeholderViewModel = HomeViewController.SignInPlaceholderView.ViewModel()
        
        let cellsViewModels = CurrentValueSubject<[[BaseProfileTableCellViewModel]], Never>([])
        
        private let services: Services
        let transitions: Transitions
        
        init(transitions: Transitions, services: Services) {
            self.transitions = transitions
            self.services = services
            
            super.init()
            
            setupData(with:
                        User(id: UUID(), name: "Maksim Sashcheka", login: "sashheko", email: "sashchekam@gmail.com", role: .admin, imageURL: URL(string: "https://firebasestorage.googleapis.com:443/v0/b/imagestorage-a16f8.appspot.com/o/images%2F3641BC6A-23C9-4638-805C-6F5CC2136152.jpg?alt=media&token=8c5c2d04-f887-43c7-8840-384fe9cd1ac1"), webPageURL: URL(string: "https://www.google.com/?client=safari"))
            )
        }
    }
}

// MARK: - HomeViewModel+NestedTypes
extension HomeViewController.ViewModel {
    struct Transitions: ScreenTransitions {
        let signIn: (@escaping Closure.Void) -> Void
        let signUp: (@escaping Closure.Void) -> Void
    }
    
    final class Services {
        let auth: AuthServiceProtocol
        
        init(auth: AuthServiceProtocol) {
            self.auth = auth
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
    func setupData(with user: User) {
        var infoViewModels = [[BaseProfileTableCellViewModel]]()
        infoViewModels.append(
            [
                ProfileCellViewModel(title: "ID", description: String(user.id.uuidString.prefix(8))),
                ProfileCellViewModel(title: "Username", description: user.name),
                ProfileCellViewModel(title: "Login", description: user.login),
                ProfileCellViewModel(title: "Email", description: user.email),
                ProfileCellViewModel(title: "User Role", description: user.role.rawValue, isSeparatorLineHidden: true)
            ]
        )
        if !user.webPageURL.isNil {
            infoViewModels.append([
                ProfileCellViewModel(
                    title: "Personal Web Page",
                    description: .empty,
                    isSeparatorLineHidden: true,
                    type: .action,
                    selectClosure: { [weak self] in
                        print("select web page")
                    }
                )
            ])
        }
        
        infoViewModels.append([
            HomeViewController.ActionTableCell.ViewModel(
                title: "Log Out",
                selectClosure: { [weak self] in
                    print("log out action")
                }
            )
        ])
        
        cellsViewModels.send(infoViewModels)
    }
}

// MARK: - HomeViewModel+TapActions
extension HomeViewController.ViewModel {
    func didTapSignInButton() {
        transitions.signIn {
            print("sign in finished")
        }
    }
    
    func didTapSignUpButton() {
        transitions.signUp {
            print("sign up finished")
        }
    }
}

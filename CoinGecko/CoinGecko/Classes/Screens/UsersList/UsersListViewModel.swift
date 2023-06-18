//
//  UsersListViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 28.05.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import Core
import Utils

extension UsersListViewController {
    final class ViewModel: ScreenTransitionable, HandlersAccessible {
        private let services: Services
        let transitions: Transitions
        
        let cellsViewModels = CurrentValueSubject<[UserTableCell.ViewModel], Never>([])
        
        init(transitions: Transitions, services: Services) {
            self.transitions = transitions
            self.services = services
            
            fetchUsersData()
        }
    }
}

// MARK: - UsersListViewModel+NestedTypes
extension UsersListViewController.ViewModel {
    struct Transitions: ScreenTransitions {
        let userDetails: Closure.UUID
    }
    
    final class Services {
        let users: UsersServiceProtocol
        
        init(users: UsersServiceProtocol) {
            self.users = users
        }
    }
}

// MARK: - UsersListViewModel+TableViewDataProviders
extension UsersListViewController.ViewModel {
    var numberOfItems: Int { cellsViewModels.value.count }

    func cellViewModel(for indexPath: IndexPath) -> UserTableCell.ViewModel {
        cellsViewModels.value[indexPath.row]
    }

    func selectRow(at indexPath: IndexPath) {
        cellViewModel(for: indexPath).selectClosure()
    }
}

// MARK: - UsersListViewModel+Private
private extension UsersListViewController.ViewModel {
    func fetchUsersData() {
        activityIndicator.show()
        services.users.fetchUsers(
            fromCache: false,
            success: { [weak self] in
                self?.activityIndicator.hide()
                self?.setupCellsViewModels(from: $0)
            },
            failure: errorsHandler.handleClosure(completion: {
                [weak self] in self?.activityIndicator.hide()
            })
        )
    }
    
    func setupCellsViewModels(from users: [User]) {
        cellsViewModels.send(
            users.map { user in
                UserTableCell.ViewModel(
                    imageURL: user.imageURL,
                    name: user.name,
                    selectClosure: { [weak self] in
                        self?.transitions.userDetails(user.id)
                    }
                )
            }
        )
    }
}

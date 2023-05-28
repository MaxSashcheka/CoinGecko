//
//  ExternalProfileViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 28.05.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import Core
import Utils

extension ExternalProfileViewController {
    final class ViewModel: ErrorHandableViewModel, ScreenTransitionable {
        private typealias Texts = L10n.Home.TableRow
        
        let cellsViewModels = CurrentValueSubject<[ProfileTableCell.ViewModel], Never>([])
        let profileImageURL = CurrentValueSubject<URL?, Never>(nil)
        let profileName = CurrentValueSubject<String, Never>(.empty)
        
        private let services: Services
        let transitions: Transitions
        
        init(userId: UUID, transitions: Transitions, services: Services) {
            self.transitions = transitions
            self.services = services
            
            super.init()
            
            fetchUserData(userId: userId)
        }
    }
}

// MARK: - ExternalProfileViewModel+NestedTypes
extension ExternalProfileViewController.ViewModel {
    struct Transitions: ScreenTransitions { }
    
    final class Services {
        let users: UsersServiceProtocol
        
        init(users: UsersServiceProtocol) {
            self.users = users
        }
    }
}

// MARK: - ExternalProfileViewModel+TableViewDataProviders
extension ExternalProfileViewController.ViewModel {
    var numberOfItems: Int { cellsViewModels.value.count }
    
    func cellViewModel(for indexPath: IndexPath) -> ProfileTableCell.ViewModel {
        cellsViewModels.value[indexPath.row]
    }
}

private extension ExternalProfileViewController.ViewModel {
    func fetchUserData(userId: UUID) {
        services.users.fetchUser(
            id: userId,
            fromCache: true,
            success: { [weak self] in self?.setupData(with: $0) },
            failure: { [weak self] in self?.errorHandlerClosure?($0) }
        )
    }
    
    func setupData(with user: User) {
        profileName.send(user.name)
        profileImageURL.send(user.imageURL)

        cellsViewModels.send([
            ProfileTableCell.ViewModel(title: Texts.id, description: String(user.id.uuidString.prefix(8))),
            ProfileTableCell.ViewModel(title: Texts.username, description: user.name),
            ProfileTableCell.ViewModel(title: Texts.login, description: user.login),
            ProfileTableCell.ViewModel(title: Texts.email, description: user.email),
            ProfileTableCell.ViewModel(title: Texts.userRole, description: user.role.rawValue, isSeparatorLineHidden: true)
        ])
    }
}

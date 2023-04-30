//
//  HomeViewController.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 10.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import SafeSFSymbols
import SnapKit
import Utils

final class HomeViewController: ViewController {

    private let placeholderView = SignInPlaceholderView()
    
    private let tableView: TableView = .make(style: .insetGrouped) {
        $0.register(ProfileTableCell.self)
        $0.register(ActionTableCell.self)
        $0.separatorStyle = .none
    }
    
    override var backgroundColor: UIColor { Assets.Colors.platinum.color }
    override var tabBarTitle: String { L10n.Tabbar.Title.home }
    override var tabBarImage: UIImage? { UIImage(.house) }
    
    private let headerView: View = .make {
        $0.clipsToBounds = true
    }
    private let profileImageView = RemoteImageView(placeholder: .color(.gray))
    
    var viewModel: ViewModel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = L10n.Home.title
        
        profileImageView.layer.cornerRadius = 30
        profileImageView.clipsToBounds = true
        
        viewModel.errorHandlerClosure = errorHandler
    }
    
    // MARK: - Methods
    
    override func arrangeSubviews() {
        super.arrangeSubviews()
        
        headerView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.top.equalToSuperview().inset(17)
        }
    }
    
    override func bindData() {
        super.bindData()
        
        viewModel.cellsViewModels
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.profileImageURL
            .bind(to: \.imageURL, on: profileImageView)
            .store(in: &cancellables)
        
        viewModel.isTableVisible
            .sink { [weak self] in
                self?.setTableVisibillity(isHidden: !$0)
            }
            .store(in: &cancellables)
        
        viewModel.placeholderViewModel.tapSubject
            .filter { $0 == .signIn }
            .sink { [weak viewModel] _ in
                viewModel?.didTapSignInButton()
            }
            .store(in: &cancellables)
        
        viewModel.placeholderViewModel.tapSubject
            .filter { $0 == .signUp }
            .sink { [weak viewModel] _ in
                viewModel?.didTapSignUpButton()
            }
            .store(in: &cancellables)
    }
    
    override func setupData() {
        super.setupData()
        
        tableView.delegate = self
        tableView.dataSource = self
    
        placeholderView.viewModel = viewModel.placeholderViewModel
    }
}

// MARK: - HomeViewController+SetTableVisibillity
private extension HomeViewController {
    func setTableVisibillity(isHidden: Bool) {
        if isHidden {
            tableView.removeFromSuperview()
            view.addSubview(placeholderView)
            placeholderView.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.trailing.equalToSuperview().inset(45)
            }
        } else {
            placeholderView.removeFromSuperview()
            view.addSubview(tableView)
            tableView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
}

extension HomeViewController: UITableViewPresentable {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == .zero else { return nil }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard section == .zero else { return .zero }
        return 380
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems(for: section)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.cellViewModel(for: indexPath) {
        case let profileViewModel as ProfileTableCell.ViewModel:
            guard let cell = tableView.reuse(ProfileTableCell.self, indexPath) else {
                assertionFailure("Cannot deque reusable cell for \(ProfileTableCell.reuseIdentifier) identifier")
                return UITableViewCell()
            }
            cell.viewModel = profileViewModel
            return cell
        case let actionViewModel as ActionTableCell.ViewModel:
            guard let cell = tableView.reuse(ActionTableCell.self, indexPath) else {
                assertionFailure("Cannot deque reusable cell for \(ActionTableCell.reuseIdentifier) identifier")
                return UITableViewCell()
            }
            cell.viewModel = actionViewModel
            return cell
        default:
            return UITableViewCell()
        }
    }
}

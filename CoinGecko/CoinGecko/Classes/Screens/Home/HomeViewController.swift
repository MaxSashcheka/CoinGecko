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
        
        title = "Home"
        
        profileImageView.layer.cornerRadius = 30
        profileImageView.clipsToBounds = true
        
        profileImageView.imageURL = URL(string: "https://firebasestorage.googleapis.com:443/v0/b/imagestorage-a16f8.appspot.com/o/images%2F3641BC6A-23C9-4638-805C-6F5CC2136152.jpg?alt=media&token=8c5c2d04-f887-43c7-8840-384fe9cd1ac1")
        
        viewModel.errorHandlerClosure = errorHandler
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        profileImageView.layer.cornerRadius = 20
    }
    
    // MARK: - Methods
    
    override func arrangeSubviews() {
        super.arrangeSubviews()
        
        headerView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.top.equalToSuperview().inset(17)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
//        view.addSubview(placeholderView)
//        placeholderView.snp.makeConstraints { make in
//            make.centerY.equalToSuperview()
//            make.leading.trailing.equalToSuperview().inset(45)
//        }
    }
    
    override func bindData() {
        super.bindData()
        
        viewModel.cellsViewModels
            .sink { [weak self] _ in
                self?.tableView.reloadData()
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

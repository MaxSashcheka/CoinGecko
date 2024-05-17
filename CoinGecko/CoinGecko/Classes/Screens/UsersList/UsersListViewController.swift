//
//  UsersListViewController.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 28.05.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import SafeSFSymbols
import SnapKit
import Utils

final class UsersListViewController: ViewController {
    
    private let tableView: TableView = .make(style: .insetGrouped) {
        $0.register(UserTableCell.self)
        $0.backgroundColor = Assets.Colors.platinum.color
    }
    
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Список пользователей"
        
        view.backgroundColor = Assets.Colors.white.color
    }
    
    override func arrangeSubviews() {
        super.arrangeSubviews()
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func bindData() {
        super.bindData()
        
        viewModel.cellsViewModels
            .sink { [weak self] _ in self?.tableView.reloadData() }
            .store(in: &cancellables)
        
    }
    
    override func setupData() {
        super.setupData()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - UsersListViewController+UITableViewPresentable
extension UsersListViewController: UITableViewPresentable {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.reuse(UserTableCell.self, indexPath) else {
            assertionFailure("Cannot deque reusable cell for \(UserTableCell.reuseIdentifier) identifier")
            return UITableViewCell()
        }
        cell.viewModel = viewModel.cellViewModel(for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectRow(at: indexPath)
    }
}

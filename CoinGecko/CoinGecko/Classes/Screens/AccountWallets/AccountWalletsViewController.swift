//
//  AccountWalletsViewController.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 26.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import SafeSFSymbols
import SnapKit
import Utils

final class AccountWalletsViewController: ViewController {
    
    override var backgroundColor: UIColor { Assets.Colors.white.color }
    
    private let placeholderView = View()
    
    private let placeholderTitleLabel: Label = .make {
        $0.text = "No wallets yet."
        $0.font = .systemFont(ofSize: 25, weight: .medium)
        $0.textAlignment = .center
        $0.textColor = .darkGray
    }
    
    private let placeholderButton: Button = .make {
        $0.backgroundColor = Assets.Colors.blue.color.withAlphaComponent(0.7)
        $0.setTitle("Add wallet", for: .normal)
    }
    
    private let walletsTableView: TableView = .make {
        $0.register(WalletTableCell.self)
        $0.separatorStyle = .none
        $0.backgroundColor = Assets.Colors.platinum.color
    }
    
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Account Wallets"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.barButtonItem(
            image: UIImage(.plus),
            action: { [weak viewModel] in viewModel?.didTapComposeWalletButton() }
        )
        
        walletsTableView.delegate = self
        walletsTableView.dataSource = self
        
        viewModel.errorHandlerClosure = errorHandler
    }
    
    override func arrangeSubviews() {
        super.arrangeSubviews()
        
        view.addSubview(walletsTableView)
        walletsTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
//        view.addSubview(placeholderView)
//        placeholderView.snp.makeConstraints { make in
//            make.leading.trailing.equalToSuperview().inset(45)
//            make.centerY.equalToSuperview()
//        }
//
//        placeholderView.addSubviews([placeholderTitleLabel, placeholderButton])
//        placeholderTitleLabel.snp.makeConstraints { make in
//            make.top.leading.trailing.equalToSuperview()
//        }
//        placeholderButton.snp.makeConstraints { make in
//            make.height.equalTo(50)
//            make.leading.trailing.bottom.equalToSuperview()
//            make.top.equalTo(placeholderTitleLabel.snp.bottom).offset(20)
//        }
    }
    
    override func bindData() {
        super.bindData()
        
        viewModel.walletsViewModels
            .sink { [weak self] _ in
                self?.walletsTableView.reloadData()
            }
            .store(in: &cancellables)
        
        placeholderButton.tapPublisher
            .sink { [weak viewModel] in
                viewModel?.didTapComposeWalletButton()
            }
            .store(in: &cancellables)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        placeholderButton.layer.cornerRadius = placeholderButton.bounds.height / 2
    }
}

// MARK: - AccountWalletsViewController+UITableViewPresentable
extension AccountWalletsViewController: UITableViewPresentable {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.reuse(WalletTableCell.self, indexPath) else {
            assertionFailure("Cannot deque reusable cell for \(WalletTableCell.reuseIdentifier) identifier")
            return UITableViewCell()
        }
        cell.viewModel = viewModel.cellViewModel(for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectCell(at: indexPath)
    }
}

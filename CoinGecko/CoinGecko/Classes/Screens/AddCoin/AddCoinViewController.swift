//
//  AddCoinViewController.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 28.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import SafeSFSymbols
import SnapKit
import Utils

final class AddCoinViewController: ViewController {
    
    private let walletsTableView: TableView = .make(style: .insetGrouped) {
        $0.register(AddCoinWalletTableCell.self)
//        $0.separatorStyle = .none
        $0.backgroundColor = Assets.Colors.platinum.color
    }
    
    override var backgroundColor: UIColor { Assets.Colors.white.color }
    
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Choose wallet"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.barButtonItem(
            image: Assets.Images.cross.image,
            action: { [weak viewModel] in viewModel?.didTapCloseButton() }
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.barButtonItem(
            title: "Done",
            action: { [weak viewModel] in viewModel?.didTapDoneButton() }
        )
        
        viewModel.errorHandlerClosure = errorHandler
    }
    
    override func arrangeSubviews() {
        super.arrangeSubviews()
        
        view.addSubview(walletsTableView)
        walletsTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func bindData() {
        super.bindData()
        
        viewModel.walletsViewModels
            .sink { [weak self] _ in
                self?.walletsTableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    override func setupData() {
        super.setupData()
        
        walletsTableView.delegate = self
        walletsTableView.dataSource = self
    }
}

// MARK: - AddCoinViewController+UITableViewPresentable
extension AddCoinViewController: UITableViewPresentable {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.reuse(AddCoinWalletTableCell.self, indexPath) else {
            assertionFailure("Cannot deque reusable cell for \(AddCoinWalletTableCell.reuseIdentifier) identifier")
            return UITableViewCell()
        }
        cell.viewModel = viewModel.cellViewModel(for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectCell(at: indexPath)
    }
}

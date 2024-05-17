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
    private typealias Texts = L10n.AddCoin
    
    private let headerView = View()
    
    private let amountTitledTextField: TitledTextField = .make {
        $0.setTextInputTraitsOptions(TextInputTraitsOptions.decimal)
    }
    
    private let walletsTableView: TableView = .make(style: .insetGrouped) {
        $0.register(AddCoinWalletTableCell.self)
        $0.backgroundColor = Assets.Colors.platinum.color
    }
    
    override var backgroundColor: UIColor { Assets.Colors.white.color }
    
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Texts.title
        
        activateEndEditingTap(at: view)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.barButtonItem(
            image: Assets.Images.cross.image,
            action: { [weak viewModel] in viewModel?.didTapCloseButton() }
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.barButtonItem(
            title: Texts.Button.done,
            action: { [weak viewModel] in viewModel?.didTapDoneButton() }
        )
    }
    
    override func arrangeSubviews() {
        super.arrangeSubviews()
        
        headerView.addSubview(amountTitledTextField)
        amountTitledTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(45)
            make.top.bottom.equalToSuperview().inset(10)
        }
        
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
        
        amountTitledTextField.viewModel = viewModel.amountTitledTextFieldViewModel
        
        walletsTableView.delegate = self
        walletsTableView.dataSource = self
    }
}

// MARK: - AddCoinViewController+UITableViewPresentable
extension AddCoinViewController: UITableViewPresentable {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == .zero else { return nil }
        return headerView
    }
    
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

// MARK: - AddCoinViewController+EndEditingTappable
extension AddCoinViewController: EndEditingTappable { }

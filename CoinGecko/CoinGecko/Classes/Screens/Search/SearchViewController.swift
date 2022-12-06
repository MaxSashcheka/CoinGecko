//
//  SearchViewController.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 8.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import SnapKit
import Utils

final class SearchViewController: ViewController {
    
    // MARK: - Properties
    
    private let coinsTableView: TableView = .make(style: .grouped) {
        $0.register(CoinCell.self, forCellReuseIdentifier: CoinCell.reuseIdentifier)
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .clear
    }
    
    private let searchTextField = SearchTextField()
    
    private let searchHeaderView = View()
    
    var viewModel: ViewModel!
    
    override var backgroundColor: UIColor { Assets.Colors.platinum.color }
    override var isNavigationBarHidden: Bool { false }
    override var isTabBarHidden: Bool { true }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.errorHandlerClosure = errorHandler
    }
    
    // MARK: - Methods
    
    override func arrangeSubviews() {
        super.arrangeSubviews()
        
        searchHeaderView.addSubview(searchTextField)
        searchTextField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        
        view.addSubview(coinsTableView)
        coinsTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func bindData() {
        super.bindData()
        
        Publishers.CombineLatest(viewModel.coinsViewModels, viewModel.nftsViewModels)
            .sink { [weak self] _ in
                self?.coinsTableView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.searchTextFieldViewModel.searchQuery
            .removeDuplicates()
            .debounce(for: .milliseconds(800), scheduler: RunLoop.main)
            .sink { [weak viewModel] in
                viewModel?.search(query: $0)
            }
            .store(in: &cancellables)
        
        viewModel.searchTextFieldViewModel.returnSubject
            .sink { [weak self] in
                self?.view.endEditing(true)
            }
            .store(in: &cancellables)
    }
    
    override func setupData() {
        super.setupData()
        
        title = L10n.Search.title
        
        coinsTableView.delegate = self
        coinsTableView.dataSource = self
        
        searchTextField.viewModel = viewModel.searchTextFieldViewModel
    }
}

// MARK: - SearchViewController+UITableViewPresentable
extension SearchViewController: UITableViewPresentable {
    private typealias Texts = L10n.Search.Table.Title
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == .zero else { return nil }
        return searchHeaderView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        section == .zero ? 60 : 20
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        section == .zero ? Texts.cryptoCoin : Texts.nft
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == .zero ? viewModel.coinsCount : viewModel.nftsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinCell.reuseIdentifier, for: indexPath) as? CoinCell else {
            assertionFailure("Cannot deque reusable cell for \(CoinCell.reuseIdentifier) identifier")
            return UITableViewCell()
        }
        cell.viewModel = viewModel.cellViewModel(for: indexPath)
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectCoin(at: indexPath)
    }
}

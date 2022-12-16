//
//  TrendingViewController.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 14.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import SafeSFSymbols
import SnapKit
import Utils

final class TrendingViewController: ViewController {
    
    // MARK: - Properties
    
    private let coinsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CoinCell.self, forCellReuseIdentifier: CoinCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        
        return tableView
    }()
    
    override var backgroundColor: UIColor { Assets.Colors.platinum.color }
    override var prefersLargeTitles: Bool { true }
    override var tabBarTitle: String { L10n.Tabbar.Title.trending }
    override var tabBarImage: UIImage? { UIImage(.chart.lineUptrendXyaxis) }
    
    var viewModel: ViewModel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchCoins()
        viewModel.errorHandlerClosure = errorHandler
    }
    
    // MARK: - Methods
    
    override func arrangeSubviews() {
        super.arrangeSubviews()
        
        view.addSubview(coinsTableView)
        coinsTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func setupData() {
        super.setupData()
        
        coinsTableView.delegate = self
        coinsTableView.dataSource = self
        
        title = L10n.Trending.title
    }
    
    override func bindData() {
        super.bindData()
        
        viewModel.coinsViewModels
            .sink { [weak coinsTableView] _ in
                coinsTableView?.reloadData()
            }
            .store(in: &cancellables)
        
        coinsTableView.publisher(for: \.contentOffset)
            .sink { [weak self] in
                guard let self = self else { return }
                if $0.y + self.coinsTableView.frame.height > self.coinsTableView.contentSize.height, self.coinsTableView.contentSize.height > .zero {
                    self.viewModel.fetchCoins()
                }
            }
            .store(in: &cancellables)
    }
}

// MARK: - TrendingViewController+UITableViewPresentable
extension TrendingViewController: UITableViewPresentable {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.coinsCount
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

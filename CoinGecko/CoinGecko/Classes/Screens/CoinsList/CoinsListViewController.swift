//
//  CoinsListViewController.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 14.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import SnapKit
import Utils

final class CoinsListViewController: ViewController {
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
    override var tabBarTitle: String { "Home" }
    override var tabBarImage: UIImage? { UIImage(systemName: "house") }
    
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchCoins()
        viewModel.errorHandlerClosure = errorHandler
    }
    
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
        
        title = "Trending Coins"
    }
    
    override func bindData() {
        super.bindData()
        
        viewModel.coinsViewModels
            .sink { [weak self] _ in
                self?.coinsTableView.reloadData()
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

extension CoinsListViewController: UITableViewPresentable {
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

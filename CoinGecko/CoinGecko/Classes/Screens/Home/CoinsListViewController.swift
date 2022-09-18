//
//  CoinsListViewController.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 14.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import RxCocoa
import RxSwift
import SnapKit
import Utils

final class CoinsListViewController: ViewController {
    private let coinsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CoinCell.self, forCellReuseIdentifier: CoinCell.reuseIdentifier)
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    override var backgroundColor: UIColor { Assets.Colors.platinum.color }
    override var prefersLargeTitles: Bool { true }
    
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Trending Coins"
        
        viewModel.fetchCoins()
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
    }
    
    override func bindData() {
        super.bindData()
        
        viewModel.coinsViewModels
            .asDriver()
            .drive(onNext: { [weak self] _ in
                self?.coinsTableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

extension CoinsListViewController: UITableViewDelegate, UITableViewDataSource {
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
}

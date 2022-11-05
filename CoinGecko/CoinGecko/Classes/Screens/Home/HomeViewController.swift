//
//  HomeViewController.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 10.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import SnapKit
import Utils

final class HomeViewController: ViewController {
    private let navigationBarView = HomeNavigationBarView()
    
    private let coinsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(NetworthCoinCell.self, forCellReuseIdentifier: NetworthCoinCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        return tableView
    }()
    
    
//    private let containerScrollView = UIScrollView()
//    private let containerStackView = UIStackView(axis: .vertical,
//                                                 spacing: 20,
//                                                 distribution: .equalSpacing)
    
    private let tableViewHeaderView = View()
    private let networhCardView = NetworhCardView()
    
    override var isNavigationBarHidden: Bool { true }
    override var backgroundColor: UIColor { Assets.Colors.platinum.color }
    override var tabBarTitle: String { "Home" }
    override var tabBarImage: UIImage? { UIImage(systemName: "house") }
    
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchPortfolioCoins()
        viewModel.errorHandlerClosure = errorHandler
    }
    
    override func arrangeSubviews() {
        super.arrangeSubviews()
        
        view.addSubview(navigationBarView)
        navigationBarView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(140)
        }
        
        view.addSubview(coinsTableView)
        coinsTableView.snp.makeConstraints { make in
            make.top.equalTo(navigationBarView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        tableViewHeaderView.addSubview(networhCardView)
        networhCardView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.bottom.equalToSuperview().inset(15)
        }
        
//        view.addSubview(containerScrollView)
//        containerScrollView.snp.makeConstraints { make in
//            make.top.equalTo(navigationBarView.snp.bottom)
//            make.leading.trailing.equalToSuperview()
//            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
//            make.centerX.equalToSuperview()
//        }
//
//        containerScrollView.addSubview(containerStackView)
//        containerStackView.snp.makeConstraints { make in
//            make.leading.trailing.equalToSuperview().inset(20)
//            make.top.bottom.equalToSuperview().inset(15)
//            make.centerX.equalToSuperview()
//        }
//        containerStackView.addArrangedSubview(networhCardView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        coinsTableView.contentOffset = .init(x: .zero, y: -450)
        UIView.animate(withDuration: 0.67, animations: {
            self.coinsTableView.contentOffset = .zero
        })
        
        coinsTableView.alpha = 0
        UIView.animate(withDuration: 0.9, animations: {
            self.coinsTableView.alpha = 1
        })
        
        
    }
    
    override func bindData() {
        super.bindData()
        
        viewModel.coinsViewModels
            .sink { [weak coinsTableView] _ in
                coinsTableView?.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.navigationBarViewModel.profileButtonSubject
            .sink { [weak viewModel] in
                viewModel?.didTapProfileButton()
            }
            .store(in: &cancellables)
        
        viewModel.navigationBarViewModel.settingsButtonSubject
            .sink { [weak viewModel] in
                viewModel?.didTapSettingsButton()
            }
            .store(in: &cancellables)
        
    }
    
    override func setupData() {
        super.setupData()
        
        coinsTableView.delegate = self
        coinsTableView.dataSource = self
        
        navigationBarView.viewModel = viewModel.navigationBarViewModel
        networhCardView.viewModel = viewModel.networthCardViewModel
    }
}

extension HomeViewController: UITableViewPresentable {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == .zero else { return nil }
        return tableViewHeaderView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.coinsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NetworthCoinCell.reuseIdentifier, for: indexPath) as? NetworthCoinCell else {
            assertionFailure("Cannot deque reusable cell for \(NetworthCoinCell.reuseIdentifier) identifier")
            return UITableViewCell()
        }
        cell.viewModel = viewModel.cellViewModel(for: indexPath)
        
        return cell
    }
    
    
}

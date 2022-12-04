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
    private typealias Texts = L10n.Home.Placeholder
    
    // MARK: - Properties
    
    private let navigationBarView = HomeNavigationBarView()
    
    private let coinsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(NetworthCoinCell.self, forCellReuseIdentifier: NetworthCoinCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        return tableView
    }()
    
    private let placeholderTitleLabel: Label = makeView {
        $0.text = Texts.title
        $0.font = .systemFont(ofSize: 24, weight: .semibold)
        $0.textColor = .black
        $0.textAlignment = .center
    }
    
    private let placeholderSubtitleLabel: Label = makeView {
        $0.text = Texts.subtitle
        $0.font = .systemFont(ofSize: 21, weight: .semibold)
        $0.textColor = .darkGray
        $0.textAlignment = .center
    }
    
    private let placeholderStackView = UIStackView(axis: .vertical,
                                                   spacing: 3,
                                                   distribution: .equalSpacing)
    
    private let tableHeaderView = View()
    
    private let networhCardView = NetworhCardView()
    
    override var isNavigationBarHidden: Bool { true }
    override var backgroundColor: UIColor { Assets.Colors.platinum.color }
    override var tabBarTitle: String { L10n.Tabbar.Title.home }
    override var tabBarImage: UIImage? { UIImage(.house) }
    
    var viewModel: ViewModel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.errorHandlerClosure = errorHandler
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.fetchPortfolioCoins()
    }
    
    // MARK: - Methods
    
    override func arrangeSubviews() {
        super.arrangeSubviews()
        
        view.addSubview(navigationBarView)
        navigationBarView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(140)
        }
        
        arrangeTableView()
        
        tableHeaderView.addSubview(networhCardView)
        networhCardView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.bottom.equalToSuperview().inset(15)
        }
        
        placeholderStackView.addArrangedSubviews([placeholderTitleLabel, placeholderSubtitleLabel])
    }
    
    override func bindData() {
        super.bindData()
        
        viewModel.coinsViewModels
            .sink { [weak self] in
                guard let self = self else { return }
                if $0.isEmpty {
                    self.coinsTableView.removeFromSuperview()
                    self.arrangePlaceholderStack()
                } else {
                    self.placeholderStackView.removeFromSuperview()
                    self.arrangeTableView()
                    self.coinsTableView.reloadData()
                }
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
        
        viewModel.deleteCoinSubject
            .sink { [weak viewModel] in
                viewModel?.deleteCoin(withId: $0)
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

// MARK: - HomeViewController+ArrangeViews
private extension HomeViewController {
    func arrangeTableView() {
        view.addSubview(coinsTableView)
        coinsTableView.snp.makeConstraints { make in
            make.top.equalTo(navigationBarView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func arrangePlaceholderStack() {
        view.addSubview(placeholderStackView)
        placeholderStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

// MARK: - HomeViewController+UITableViewPresentable
extension HomeViewController: UITableViewPresentable {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.coinsCount
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == .zero else { return nil }
        return tableHeaderView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NetworthCoinCell.reuseIdentifier, for: indexPath) as? NetworthCoinCell else {
            assertionFailure("Cannot deque reusable cell for \(NetworthCoinCell.reuseIdentifier) identifier")
            return UITableViewCell()
        }
        cell.viewModel = viewModel.cellViewModel(for: indexPath)
        cell.viewModel?.deleteSubject = viewModel.deleteCoinSubject
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectCoin(at: indexPath)
    }
}

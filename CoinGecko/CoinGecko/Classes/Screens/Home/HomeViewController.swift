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
    private typealias TextStyles = AppStyle.TextStyles.Home.Placeholder
    private typealias Colors = AppStyle.Colors.Home
    
    // MARK: - Properties
    
    private let navigationBarView = HomeNavigationBarView()
    
    private let coinsTableView: TableView = .make(style: .grouped) {
        $0.register(NetworthCoinCell.self)
        $0.separatorStyle = .none
        $0.backgroundColor = Colors.table
    }
    
    private let placeholderTitleLabel: Label = .make {
        $0.apply(TextStyles.title)
        $0.text = Texts.title
        $0.textAlignment = .center
    }
    
    private let placeholderSubtitleLabel: Label = .make {
        $0.apply(TextStyles.subtitle)
        $0.text = Texts.subtitle
        $0.textAlignment = .center
    }
    
    private let placeholderStackView = UIStackView(axis: .vertical,
                                                   spacing: 3,
                                                   distribution: .equalSpacing)
    
    private let tableHeaderView = View()
    
    private let networhCardView = NetworhCardView()
    
    override var isNavigationBarHidden: Bool { true }
    override var backgroundColor: UIColor { Colors.background }
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
        guard let cell = tableView.reuse(NetworthCoinCell.self, indexPath) else {
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

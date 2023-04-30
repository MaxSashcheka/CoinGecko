//
//  MarketsViewController.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 1.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import SafeSFSymbols
import SnapKit
import Utils

final class MarketsViewController: ViewController {
    private typealias Texts = L10n.Markets
    private typealias TextsStyles = AppStyle.TextStyles.Markets
    private typealias Colors = AppStyle.Colors.Markets
    
    // MARK: - Properties
    
    private let statusPlaceholderLabel: Label = .make {
        $0.apply(TextsStyles.statusPlaceholder)
    }
    
    private let statusPercentageLabel: Label = .make {
        $0.apply(TextsStyles.statusPercentage)
    }
    
    private let statusTriangleView = PriceTriangleView(backgroundColor: .clear)
    
    private let statusTimePlaceholderLabel: Label = .make {
        $0.apply(TextsStyles.statusTimePlaceholder)
        $0.text = Texts.TimePlaceholder.title
    }
    
    private let searchButton: Button = .make {
        $0.setImage(Assets.Images.search.image.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = Colors.tint
    }
    
    private let pageButtonsCollectionView = PageButtonsCollectionView()
    
    private let separatorLine = View(backgroundColor: Colors.separatorLine)
    
    private let coinsTableView: TableView = .make {
        $0.register(CoinCell.self)
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = Colors.table
    }
    
    override var backgroundColor: UIColor { Colors.background }
    override var isNavigationBarHidden: Bool { true }
    override var tabBarTitle: String { L10n.Tabbar.Title.markets }
    override var tabBarImage: UIImage? { UIImage(.chart.pie) }
    
    var viewModel: ViewModel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: - add pull to refresh
        viewModel.errorHandlerClosure = errorHandler
        
        viewModel.fetchGlobalData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.fetchCoins()
    }
    
    // MARK: - Methods
    
    override func arrangeSubviews() {
        super.arrangeSubviews()
        
        view.addSubview(statusPlaceholderLabel)
        statusPlaceholderLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(statusPercentageLabel)
        statusPercentageLabel.snp.makeConstraints { make in
            make.leading.equalTo(statusPlaceholderLabel.snp.trailing).offset(3)
            make.centerY.equalTo(statusPlaceholderLabel)
        }
        
        view.addSubview(statusTriangleView)
        statusTriangleView.snp.makeConstraints { make in
            make.leading.equalTo(statusPercentageLabel.snp.trailing).offset(5)
            make.size.equalTo(20)
            make.bottom.equalTo(statusPercentageLabel).offset(-7)
        }
        
        view.addSubview(statusTimePlaceholderLabel)
        statusTimePlaceholderLabel.snp.makeConstraints { make in
            make.leading.equalTo(statusPlaceholderLabel)
            make.top.equalTo(statusPlaceholderLabel.snp.bottom).offset(3)
        }
        
        let searchButtonContainerView: View = {
            let view = View(backgroundColor: Colors.searchContainer)
            view.cornerRadius = 20
            return view
        }()
        view.addSubview(searchButtonContainerView)
        searchButtonContainerView.snp.makeConstraints { make in
            make.top.equalTo(statusPlaceholderLabel)
            make.trailing.equalToSuperview().offset(-20)
            make.size.equalTo(40)
        }
        
        searchButtonContainerView.addSubview(searchButton)
        searchButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(25)
        }
        
        view.addSubview(pageButtonsCollectionView)
        pageButtonsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(statusTimePlaceholderLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(60)
        }
        
        view.addSubview(separatorLine)
        separatorLine.snp.makeConstraints { make in
            make.top.equalTo(pageButtonsCollectionView.snp.bottom).offset(3)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        view.addSubview(coinsTableView)
        coinsTableView.snp.makeConstraints { make in
            make.top.equalTo(separatorLine.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    override func setupData() {
        super.setupData()
        
        coinsTableView.delegate = self
        coinsTableView.dataSource = self
        
        pageButtonsCollectionView.viewModel = viewModel.pageButtonsCollectionViewModel
    }
    
    override func bindData() {
        super.bindData()
        
        viewModel.coinsViewModels
            .sink { [weak self] _ in
                self?.coinsTableView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.pageButtonsCollectionViewModel.selectedMode
            .sink { [weak viewModel] _ in
                viewModel?.fetchCoins()
            }
            .store(in: &cancellables)
        
        viewModel.isPriceChangePositive
            .sink { [weak self] in
                self?.statusPlaceholderLabel.text = $0
                    ? Texts.StatusTitle.up
                    : Texts.StatusTitle.down
                self?.statusTriangleView.state = $0 ? .gainer : .loser
            }
            .store(in: &cancellables)
        
        viewModel.changePercentage
            .sink { [weak self] changePercentage in
                let isChangePercentagePositive = changePercentage > .zero
                var priceChangeString = preciseRound(changePercentage, precision: .hundredths).description
                priceChangeString.insert(contentsOf: isChangePercentagePositive ? "+" : .empty,
                                         at: priceChangeString.startIndex)
                priceChangeString.insert(contentsOf: String.percent, at: priceChangeString.endIndex)
                // TODO: - this logic with creating priceChangeString should become reusable
                
                self?.statusPercentageLabel.text = priceChangeString
                self?.statusPercentageLabel.textColor = isChangePercentagePositive ? Colors.positiveChange : Colors.negativeChange
            }
            .store(in: &cancellables)
        
        coinsTableView.publisher(for: \.contentOffset)
            .sink { [weak self] contentOffset in
                self?.separatorLine.alpha = contentOffset.y <= .zero ? 0 : 1
            }
            .store(in: &cancellables)
        
        searchButton.tapPublisher
            .sink { [weak viewModel] in
                viewModel?.didTapSearchButton()
            }
            .store(in: &cancellables)
    }
}

// MARK: - MarketsViewController+UITableViewPresentable
extension MarketsViewController: UITableViewPresentable {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.coinsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.reuse(CoinCell.self, indexPath) else {
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

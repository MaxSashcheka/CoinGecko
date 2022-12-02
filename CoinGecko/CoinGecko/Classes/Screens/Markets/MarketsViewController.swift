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
    typealias Texts = L10n.Markets
    // MARK: - Properties
    
    private let statusPlaceholderLabel: Label = {
        let label = Label()
        label.font = .systemFont(ofSize: 28, weight: .medium)
        
        return label
    }()
    
    private let statusPercentageLabel: Label = {
        let label = Label()
        label.font = .systemFont(ofSize: 28, weight: .medium)
        label.textColor = .systemRed
        
        return label
    }()
    
    private let statusTriangleView = PriceTriangleView(backgroundColor: .clear)
    
    private let statusTimePlaceholderLabel: Label = {
        let label = Label()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .darkGray
        label.text = Texts.TimePlaceholder.title
        
        return label
    }()
    
    private let searchButton: Button = {
        let button = Button()
        button.setImage(Assets.Images.search.image.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .darkGray
        
        return button
    }()
    
    private let pageButtonsCollectionView = PageButtonsCollectionView()
    
    private let separatorLine = View(backgroundColor: .lightGray.withAlphaComponent(0.7))
    
    private let coinsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CoinCell.self, forCellReuseIdentifier: CoinCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        
        return tableView
    }()
    
    override var backgroundColor: UIColor { Assets.Colors.platinum.color }
    override var isNavigationBarHidden: Bool { true }
    override var tabBarTitle: String { L10n.Tabbar.Title.markets }
    override var tabBarImage: UIImage? { UIImage(.chart.pie) }
    
    var viewModel: ViewModel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: - add pull to refresh
        viewModel.errorHandlerClosure = errorHandler
        viewModel.fetchCoins(mode: .all)
        viewModel.fetchGlobalData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.fetchFavouritesCoins()
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
            let view = View(backgroundColor: .lightGray.withAlphaComponent(0.2))
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
            make.leading.trailing.equalToSuperview().inset(20)
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
        
        viewModel.pageButtonsCollectionViewModel.selectModeSubject
            .sink { [weak viewModel] in
                viewModel?.fetchCoins(mode: $0)
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
                self?.statusPercentageLabel.textColor = isChangePercentagePositive ? .green : .red
            }
            .store(in: &cancellables)
        
        coinsTableView.publisher(for: \.contentOffset)
            .sink { [weak self] contentOffset in
                self?.separatorLine.alpha = contentOffset.y <= .zero ? 0 : 1
            }
            .store(in: &cancellables)
        
        searchButton.tapPublisher()
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

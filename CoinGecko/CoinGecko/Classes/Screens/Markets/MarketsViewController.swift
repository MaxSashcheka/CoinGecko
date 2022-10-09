//
//  MarketsViewController.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 1.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import SnapKit
import Utils

final class MarketsViewController: ViewController {
    private let statusPlaceholderLabel: Label = {
        let label = Label()
        label.font = .systemFont(ofSize: 28, weight: .medium)
        label.text = "Market is down"
        
        return label
    }()
    
    private let statusPercentageLabel: Label = {
        let label = Label()
        label.font = .systemFont(ofSize: 28, weight: .medium)
        label.textColor = .systemRed
        label.text = "-11.47 %"
        
        return label
    }()
    
    private let statusTimePlaceholderLabel: Label = {
        let label = Label()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .darkGray
        label.text = "In the past 24 hours"
        
        return label
    }()
    
    private let searchButton: Button = {
        let button = Button()
        button.setImage(Assets.Images.search.image, for: .normal)
        
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
    
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: - ADD pull to refresh
        viewModel.errorHandlerClosure = errorHandler
        viewModel.fetchCoins(mode: .all)
        
        title = .empty
        navigationController?.tabBarItem.title = "Markets"
        navigationController?.tabBarItem.image = UIImage(systemName: "chart.xyaxis.line")
    }
    
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
        
        view.addSubview(statusTimePlaceholderLabel)
        statusTimePlaceholderLabel.snp.makeConstraints { make in
            make.leading.equalTo(statusPlaceholderLabel)
            make.top.equalTo(statusPlaceholderLabel.snp.bottom).offset(3)
        }
        
        view.addSubview(searchButton)
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(statusPlaceholderLabel)
            make.trailing.equalToSuperview().offset(-20)
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
        
        viewModel.statusPlaceholderText
            .bind(to: \.text, on: statusPlaceholderLabel)
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

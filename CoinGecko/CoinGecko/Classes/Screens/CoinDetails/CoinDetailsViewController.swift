//
//  CoinDetailsViewController.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 18.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Charts
import Combine
import SnapKit
import Utils

final class CoinDetailsViewController: ViewController {
    private typealias TextStyles = AppStyle.TextStyles.CoinDetails
    private typealias Colors = AppStyle.Colors.CoinDetails
    
    // MARK: - Properties
    
    private let scrollView = UIScrollView()
    
    private let currentPriceLabel: Label = .make {
        $0.apply(TextStyles.currentPrice)
    }
    
    private let priceChangeLabel: Label = .make {
        $0.apply(TextStyles.priceChange)
    }
    
    private let chartView = ChartView()
    
    private let buttonsCollectionView = ButtonsCollectionView()
    
    private let addToPortfolioButton: Button = .make {
        $0.setTitle(L10n.CoinDetails.AddButton.title, for: .normal)
        $0.backgroundColor = Colors.addButton
    }
    
    private let coinImageView = RemoteImageView()
    
    private let coinTitleLabel = Label()
    
    var viewModel: ViewModel!
    
    override var backgroundColor: UIColor { Colors.background }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.errorHandlerClosure = errorHandler
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.barButtonItem(
            image: Assets.Images.cross.image,
            action: { [weak viewModel] in viewModel?.didTapCloseButton() }
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.barButtonItem(
            image: UIImage(.network),
            action: { [weak viewModel] in viewModel?.didTapBrowserButton() }
        )
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        addToPortfolioButton.cornerRadius = addToPortfolioButton.frame.height / 2
    }
    
    // MARK: - Methods
    
    override func arrangeSubviews() {
        super.arrangeSubviews()
        
        let infoContainerView = View()
        infoContainerView.addSubview(coinImageView)
        infoContainerView.addSubview(coinTitleLabel)
        
        coinImageView.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.leading.top.bottom.equalToSuperview()
        }
        
        coinTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(coinImageView)
            make.leading.equalTo(coinImageView.snp.trailing).offset(5)
            make.trailing.equalToSuperview()
        }
        
        navigationItem.titleView = infoContainerView
          
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(currentPriceLabel)
        currentPriceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(15)
        }
        
        scrollView.addSubview(priceChangeLabel)
        priceChangeLabel.snp.makeConstraints { make in
            make.leading.equalTo(currentPriceLabel.snp.trailing).offset(8)
            make.bottom.equalTo(currentPriceLabel).offset(-2)
        }
        
        scrollView.addSubview(chartView)
        chartView.snp.makeConstraints { make in
            make.top.equalTo(currentPriceLabel.snp.bottom).offset(35)
            make.leading.trailing.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(chartView.snp.width).multipliedBy(1.15)
        }
        
        scrollView.addSubview(buttonsCollectionView)
        buttonsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(chartView.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(33)
        }
        
        scrollView.addSubview(addToPortfolioButton)
        addToPortfolioButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(buttonsCollectionView)
            make.top.equalTo(buttonsCollectionView.snp.bottom).offset(35)
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(55)
        }
    }
    
    override func bindData() {
        super.bindData()
        
        addToPortfolioButton.tapPublisher
            .sink { [weak viewModel] in
                viewModel?.didTapAddToWalletButton()
            }
            .store(in: &cancellables)
        
        viewModel.buttonsCollectionViewModel.selectTimeIntervalSubject
            .removeDuplicates()
            .sink { [weak viewModel] in
                viewModel?.fetchCoinChartData(for: $0)
            }
            .store(in: &cancellables)
        
        viewModel.coinTitle
            .bind(to: \.text, on: coinTitleLabel)
            .store(in: &cancellables)
        
        viewModel.coinImageURL
            .bind(to: \.imageURL, on: coinImageView)
            .store(in: &cancellables)
        
        viewModel.priceChangeText
            .bind(to: \.text, on: priceChangeLabel)
            .store(in: &cancellables)
        
        viewModel.currentPriceText
            .bind(to: \.text, on: currentPriceLabel)
            .store(in: &cancellables)
        
        viewModel.isPriceChangePositive
            .map { $0 ? UIColor.systemGreen : .systemRed }
            .bind(to: \.textColor, on: priceChangeLabel)
            .store(in: &cancellables)
        
        viewModel.isAddToPortfolioButtonHidden
            .bind(to: \.isHidden, on: addToPortfolioButton)
            .store(in: &cancellables)
    }
    
    override func setupData() {
        super.setupData()
        
        chartView.viewModel = viewModel.chartViewModel
        buttonsCollectionView.viewModel = viewModel.buttonsCollectionViewModel
    }
}

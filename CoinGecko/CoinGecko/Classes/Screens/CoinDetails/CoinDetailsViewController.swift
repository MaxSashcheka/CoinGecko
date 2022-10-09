//
//  CoinDetailsViewController.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 18.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import SnapKit
import Utils

final class CoinDetailsViewController: ViewController {
    private let navigationBarView = CoinDetailsNavigationBarView()
    
    private let scrollView = UIScrollView()
    
    private let currentPriceLabel: Label = {
        let label = Label()
        label.font = .systemFont(ofSize: 23, weight: .bold)
        
        return label
    }()
    
    private let priceChangeLabel: Label = {
        let label = Label()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.text = "+ 1700.254 (9.77%)"
        label.textColor = .systemGreen
        
        return label
    }()
    
    private let chartView = ChartView()
    
    private let buttonsCollectionView = ButtonsCollectionView()
    
    var viewModel: ViewModel!
    
    override var backgroundColor: UIColor { .white }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.errorHandlerClosure = errorHandler
    }
    
    override func arrangeSubviews() {
        super.arrangeSubviews()
        
        view.addSubview(navigationBarView)
        navigationBarView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(53)
        }
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(navigationBarView.snp.bottom)
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
            make.height.equalTo(chartView.snp.width).multipliedBy(0.8)
        }
        
        scrollView.addSubview(buttonsCollectionView)
        buttonsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(chartView.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(33)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    override func bindData() {
        super.bindData()
        
        viewModel.navigationBarViewModel.closeButtonSubject
            .sink { [weak viewModel] in
                viewModel?.didTapCloseButton()
            }
            .store(in: &cancellables)
        
        viewModel.buttonsCollectionViewModel.selectTimeIntervalSubject
            .removeDuplicates()
            .sink { [weak viewModel] in
                viewModel?.fetchCoinChartData(for: $0)
            }
            .store(in: &cancellables)
        
        viewModel.currentPriceText
            .bind(to: \.text, on: currentPriceLabel)
            .store(in: &cancellables)
        
        viewModel.priceChangeText
            .bind(to: \.text, on: priceChangeLabel)
            .store(in: &cancellables)
        
        viewModel.isPriceChangePositive
            .sink { [weak self] in
                self?.priceChangeLabel.textColor = $0 ? .systemGreen : .systemRed
            }
            .store(in: &cancellables)
    }
    
    override func setupData() {
        super.setupData()
        
        navigationBarView.viewModel = viewModel.navigationBarViewModel
        chartView.viewModel = viewModel.chartViewModel
        buttonsCollectionView.viewModel = viewModel.buttonsCollectionViewModel
    }
}

//
//  NetworthCardView.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 29.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import SnapKit
import Utils

extension HomeViewController {
    final class NetworhCardView: View {
        private let balanceTitleLabel: Label = {
            let label = Label()
            label.font = .systemFont(ofSize: 24, weight: .regular)
            label.textColor = .white
            label.text = "Balance"
            
            return label
        }()
        
        private let balanceValueLabel: Label = {
            let label = Label()
            label.font = .systemFont(ofSize: 32, weight: .semibold)
            label.textColor = .white
            label.text = "$450.933"
            
            return label
        }()
        
        private let dayProfitTitleLabel: Label = {
            let label = Label()
            label.font = .systemFont(ofSize: 24, weight: .regular)
            label.textColor = .white
            label.text = "Day Profit"
            
            return label
        }()
        
        private let dayProfitValueLabel: Label = {
            let label = Label()
            label.font = .systemFont(ofSize: 32, weight: .semibold)
            label.textColor = .white
            label.text = "$12.484"
            
            return label
        }()
        
        var contentStackView: UIStackView {
            UIStackView(axis: .vertical, spacing: 5, distribution: .fill)
        }
        
        var viewModel: ViewModel? {
            didSet {
                cancellables.removeAll()
                guard let viewModel = viewModel else { return }
                
                arrangeSubviews()
                setupData()
                bindData(with: viewModel)
            }
        }
        
        func arrangeSubviews() {
            let balanceStackView = contentStackView
            addSubview(balanceStackView)
            
            balanceStackView.addArrangedSubviews([balanceTitleLabel, balanceValueLabel])
            balanceStackView.snp.makeConstraints { make in
                make.leading.top.equalToSuperview().offset(20)
            }

            let dayProfitStackView = contentStackView
            addSubview(dayProfitStackView)
        
            dayProfitStackView.addArrangedSubviews([dayProfitTitleLabel, dayProfitValueLabel])
            dayProfitStackView.snp.makeConstraints { make in
                make.top.equalTo(balanceStackView.snp.bottom).offset(20)
                make.leading.equalTo(balanceStackView)
                make.bottom.equalToSuperview().offset(-20)
            }
        }
        
        func bindData(with viewModel: ViewModel) {
            
        }
        
        func setupData() {
            backgroundColor = .systemBlue.withAlphaComponent(0.65)
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            layer.cornerRadius = frame.height / 8
        }
    }
}

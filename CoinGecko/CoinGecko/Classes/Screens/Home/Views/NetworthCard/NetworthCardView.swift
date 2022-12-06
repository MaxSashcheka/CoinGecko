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
        private typealias TextStyles = AppStyle.TextStyles.NetworthCard
        
        // MARK: - Properties
        
        private let balanceTitleLabel: Label = .make {
            $0.apply(TextStyles.balanceTitle)
            $0.text = L10n.Home.NetworthCard.title
        }
        
        private let balanceValueLabel: Label = .make {
            $0.apply(TextStyles.balanceValue)
        }
        
        private let dayProfitTitleLabel: Label = .make {
            $0.apply(TextStyles.dayProfitTitle)
        }
        
        private let dayProfitValueLabel: Label = .make {
            $0.apply(TextStyles.dayProfitValue)
        }
        
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
        
        // MARK: - Methods
        
        private func arrangeSubviews() {
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
        
        private func bindData(with viewModel: ViewModel) {
            viewModel.networthValue
                .bind(to: \.text, on: balanceValueLabel)
                .store(in: &cancellables)
            
            viewModel.dayProfitTitle
                .bind(to: \.text, on: dayProfitTitleLabel)
                .store(in: &cancellables)
            
            viewModel.dayProfitValue
                .bind(to: \.text, on: dayProfitValueLabel)
                .store(in: &cancellables)
        }
        
        private func setupData() {
            backgroundColor = .systemBlue.withAlphaComponent(0.65)
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            layer.cornerRadius = frame.height / 8
        }
    }
}

//
//  WalletView.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 27.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import SnapKit
import Utils

final class WalletView: View {
    private let titleLabel: Label = .make {
        $0.font = .systemFont(ofSize: 25, weight: .medium)
    }
    
    private let countLabel: Label = .make {
        $0.font = .systemFont(ofSize: 25, weight: .medium)
        $0.text = "0 \(L10n.AccountWallets.coins)"
    }
    
    var viewModel: ViewModel? {
        didSet {
            cancellables.removeAll()
            guard let viewModel = viewModel else { return }
            
            arrangeSubviews()
            bindData(with: viewModel)
            setupData()
        }
    }
}

private extension WalletView {
    func arrangeSubviews() {
        addSubviews([titleLabel, countLabel])
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(15)
        }
        
        countLabel.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview().inset(15)
        }
    }
    
    func bindData(with viewModel: ViewModel) {
        viewModel.title
            .bind(to: \.text, on: titleLabel)
            .store(in: &cancellables)
        
        viewModel.coinsCount
            .map { $0.description + L10n.AccountWallets.coins }
            .bind(to: \.text, on: countLabel)
            .store(in: &cancellables)
        
        viewModel.color
            .bind(to: \.backgroundColor, on: self)
            .store(in: &cancellables)
    }
    
    func setupData() {
        cornerRadius = 12
    }
}

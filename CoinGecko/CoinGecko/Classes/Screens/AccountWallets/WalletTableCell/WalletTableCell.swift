//
//  WalletTableCell.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 27.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import SnapKit
import Utils

final class WalletTableCell: TableCell {
    
    // MARK: - UI Components
    
    private let walletView = WalletView()
    
    var viewModel: ViewModel? {
        didSet {
            cancellables.removeAll()
            guard let viewModel = viewModel else { return }
            
            arrangeSubviews()
            setupData(with: viewModel)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        viewModel = nil
    }
}

private extension WalletTableCell {
    func arrangeSubviews() {
        contentView.addSubview(walletView)
        walletView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(25)
            make.top.bottom.equalToSuperview().inset(10)
            make.height.equalTo(100)
        }
    }
    
    func setupData(with viewModel: ViewModel) {
        backgroundColor = .clear
        selectionStyle = .none
        
        walletView.viewModel = viewModel.walletViewModel
    }
}

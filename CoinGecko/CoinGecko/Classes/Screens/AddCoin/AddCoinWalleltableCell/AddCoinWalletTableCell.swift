//
//  AddCoinWalletTableCell.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 28.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import SnapKit
import Utils

final class AddCoinWalletTableCell: TableCell {
    
    // MARK: - UI Components
    
    private let titleLabel: Label = .make {
        $0.font = .systemFont(ofSize: 18, weight: .regular)
    }
    
    private let checkmarkImageView: UIImageView = .make {
        $0.image = UIImage(.checkmark)
        $0.tintColor = .systemBlue
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
    
    override func prepareForReuse() {
        super.prepareForReuse()

        viewModel = nil
    }
}

private extension AddCoinWalletTableCell {
    func arrangeSubviews() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.bottom.equalToSuperview().inset(10)
        }
        
        contentView.addSubview(checkmarkImageView)
        checkmarkImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
    }
    
    func bindData(with viewModel: ViewModel) {
        viewModel.title
            .bind(to: \.text, on: titleLabel)
            .store(in: &cancellables)
        
        viewModel.isSelected
            .map(!)
            .bind(to: \.isHidden, on: checkmarkImageView)
            .store(in: &cancellables)
    }
    
    func setupData() {
//        backgroundColor = Assets.Colors.white.color
        selectionStyle = .none
    }
}

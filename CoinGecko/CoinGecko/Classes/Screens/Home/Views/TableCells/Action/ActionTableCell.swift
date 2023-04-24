//
//  ActionTableCell.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 24.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

extension HomeViewController {
    final class ActionTableCell: TableCell {
        
        // MARK: - UI Components
        
        private let actionLabel: Label = .make {
            $0.font = .systemFont(ofSize: 18, weight: .medium)
            $0.textColor = Assets.Colors.red.color
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
}

extension HomeViewController.ActionTableCell {
    func arrangeSubviews() {
        addSubview(actionLabel)
        actionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(10)
        }
    }
    
    func bindData(with viewModel: ViewModel) {
        viewModel.title
            .bind(to: \.text, on: actionLabel)
            .store(in: &cancellables)
    }
    
    func setupData() {
        selectionStyle = .none
    }
}

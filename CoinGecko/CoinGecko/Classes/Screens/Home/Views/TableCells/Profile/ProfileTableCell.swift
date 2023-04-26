//
//  ProfileTableCell.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 24.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import SafeSFSymbols
import Utils

extension HomeViewController {
    final class ProfileTableCell: TableCell {
        
        // MARK: - UI Components
        
        private let titleLabel: Label = .make {
            $0.textColor = Assets.Colors.black.color
            $0.font = .systemFont(ofSize: 18, weight: .regular)
        }
        
        private let descriptionLabel: Label = .make {
            $0.textColor = Assets.Colors.darkGray.color
            $0.font = .systemFont(ofSize: 18, weight: .regular)
        }
        
        private let chevronImageView: UIImageView = .make {
            $0.image = UIImage(.chevron.right)
            $0.tintColor = Assets.Colors.lightGray.color
        }
        
        private let separatorLine = View(
            backgroundColor: Assets.Colors.lightGray.color.withAlphaComponent(0.65)
        )
        
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

extension HomeViewController.ProfileTableCell {
    func arrangeSubviews() {
        addSubviews([titleLabel, descriptionLabel, chevronImageView, separatorLine])
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.top.bottom.equalToSuperview().inset(10)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
        }
        
        chevronImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
        }
        
        separatorLine.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
        }
    }
    
    func bindData(with viewModel: ViewModel) {
        viewModel.title
            .bind(to: \.text, on: titleLabel)
            .store(in: &cancellables)
        
        viewModel.description
            .bind(to: \.text, on: descriptionLabel)
            .store(in: &cancellables)
        
        viewModel.isSeparatorLineHidden
            .bind(to: \.isHidden, on: separatorLine)
            .store(in: &cancellables)
        
        viewModel.type
            .map { $0 == .common }
            .bind(to: \.isHidden, on: chevronImageView)
            .store(in: &cancellables)
        
        viewModel.type
            .map { $0 == .action }
            .bind(to: \.isHidden, on: descriptionLabel)
            .store(in: &cancellables)
    }
    
    func setupData() {
        selectionStyle = .none
    }
}

//
//  UserTableCell.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 28.05.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import SnapKit
import Utils

final class UserTableCell: TableCell {
    private let photoImageView = RemoteImageView(placeholder: .color(Assets.Colors.lightGray.color))
    
    private let titleLabel: Label = .make {
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
        $0.numberOfLines = .zero
        $0.textAlignment = .center
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        photoImageView.layer.cornerRadius = photoImageView.bounds.height / 2
        photoImageView.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        viewModel = nil
    }
}

private extension UserTableCell {
    func arrangeSubviews() {
        contentView.addSubview(photoImageView)
        photoImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.bottom.equalToSuperview().inset(10)
            make.size.equalTo(70)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(photoImageView.snp.trailing).offset(20)
            make.centerY.equalTo(photoImageView)
        }
    }
    
    func bindData(with viewModel: ViewModel) {
        viewModel.imageURL
            .bind(to: \.imageURL, on: photoImageView)
            .store(in: &cancellables)

        viewModel.name
            .bind(to: \.text, on: titleLabel)
            .store(in: &cancellables)
    }
    
    func setupData() {
//        selectionStyle = .none
//        contentView.backgroundColor = Assets.Colors.white.color
    }
}

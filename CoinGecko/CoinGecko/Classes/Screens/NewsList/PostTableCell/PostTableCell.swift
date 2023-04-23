//
//  PostTableCell.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 23.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import SnapKit
import Utils

final class PostTableCell: TableCell {
    
    // MARK: - UI Components
    
    private let containerView: View = .make {
        $0.backgroundColor = Assets.Colors.white.color
        $0.cornerRadius = 13
        $0.clipsToBounds = true
    }
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()

        viewModel = nil
    }
}

private extension PostTableCell {
    func arrangeSubviews() {
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.bottom.equalToSuperview().inset(10)
        }
        
        containerView.addSubview(photoImageView)
        photoImageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(200)
        }
        
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.leading.trailing.equalToSuperview().inset(5)
        }
    }
    
    func bindData(with viewModel: ViewModel) {
        viewModel.imageURL
            .bind(to: \.imageURL, on: photoImageView)
            .store(in: &cancellables)

        viewModel.title
            .bind(to: \.text, on: titleLabel)
            .store(in: &cancellables)
    }
    
    func setupData() {
        backgroundColor = .clear
        selectionStyle = .none
    }
}

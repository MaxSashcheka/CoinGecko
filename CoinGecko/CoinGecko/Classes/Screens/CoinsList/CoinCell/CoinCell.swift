//
//  CoinCell.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 16.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import SnapKit
import Utils
import RxCocoa
import RxSwift

extension CoinsListViewController {
    final class CoinCell: TableCell {
        private let containerShadowView: View = {
            let view = View(shadowColor: UIColor.black.withAlphaComponent(0.25),
                            shadowOffset: .zero,
                            shadowRadius: 3.0,
                            shadowOpacity: 1)
            view.backgroundColor = .white
            view.cornerRadius = 15
            
            // TODO: - Move all constants into constants enum
            
            return view
        }()
        
        private let coinImageView: RemoteImageView = {
            let imageView = RemoteImageView(placeholder: .color(.gray))
            imageView.contentMode = .scaleAspectFit
            
            return imageView
        }()
        
        private let nameTitledDescriptionView = TitledDescriptionView()
        
        private let priceInfoTitledDescriptionView = TitledDescriptionView()
        
        
        private var disposeBag = DisposeBag()
        
        var viewModel: ViewModel? {
            didSet {
                guard let viewModel = viewModel else { return }
                
                arrangeSubviews()
                setupData(with: viewModel)
            }
        }
        
        func arrangeSubviews() {
            contentView.addSubview(containerShadowView)
            containerShadowView.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(15)
                make.top.bottom.equalToSuperview().inset(7.5)
            }
            
            containerShadowView.addSubview(coinImageView)
            coinImageView.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(15)
                make.top.bottom.equalToSuperview().inset(15)
                make.size.equalTo(65)
            }
            
            containerShadowView.addSubview(nameTitledDescriptionView)
            nameTitledDescriptionView.snp.makeConstraints { make in
                make.leading.equalTo(coinImageView.snp.trailing).offset(9)
                make.centerY.equalToSuperview()
            }
            
            containerShadowView.addSubview(priceInfoTitledDescriptionView)
            priceInfoTitledDescriptionView.snp.makeConstraints { make in
                make.trailing.equalToSuperview().offset(-15)
                make.centerY.equalToSuperview()
            }
        }
        
        func setupData(with viewModel: ViewModel) {
            coinImageView.imageURL = viewModel.imageURL
            nameTitledDescriptionView.viewModel = viewModel.nameTitledDescriptionViewModel
            priceInfoTitledDescriptionView.viewModel = viewModel.priceInfoTitledDescriptionViewModel
            
            priceInfoTitledDescriptionView.setTextAlignment(to: .right)
            priceInfoTitledDescriptionView.setDescriptionLabelTextColor(
                viewModel.isPriceChangePositive ? .green : .red
            )
            
            selectionStyle = .none
        }
        
        override func prepareForReuse() {
            super.prepareForReuse()
            
            // TODO: - check if it is required to remove subviews
            viewModel = nil
        }
    }
}

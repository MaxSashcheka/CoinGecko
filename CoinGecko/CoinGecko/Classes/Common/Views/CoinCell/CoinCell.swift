//
//  CoinCell.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 16.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import SnapKit
import Utils

final class CoinCell: TableCell {
    
    // MARK: - Properties
    
    private let containerShadowView: View = {
        let view = View(shadowColor: UIColor.black.withAlphaComponent(0.25),
                        shadowOffset: .zero,
                        shadowRadius: 3.0,
                        shadowOpacity: 1)
        view.backgroundColor = .white
        view.cornerRadius = 15
        
        return view
    }()
    
    private let coinImageView: RemoteImageView = {
        let imageView = RemoteImageView(placeholder: .color(.gray))
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let nameTitledDescriptionView = TitledDescriptionView()
    
    private let priceInfoTitledDescriptionView = TitledDescriptionView()
    
    var viewModel: ViewModel? {
        didSet {
            cancellables.removeAll()
            guard let viewModel = viewModel else { return }
            
            arrangeSubviews()
            bindData(with: viewModel)
            setupData(with: viewModel)
        }
    }
    
    // MARK: - Methods
    
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
            make.trailing.equalToSuperview().offset(-50)
            make.centerY.equalToSuperview()
        }
        
        containerShadowView.addSubview(priceInfoTitledDescriptionView)
        priceInfoTitledDescriptionView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
        }
    }
    
    func bindData(with viewModel: ViewModel) {
        viewModel.imageURL
            .bind(to: \.imageURL, on: coinImageView)
            .store(in: &cancellables)
        
        viewModel.isPriceChangePositive
            .sink { [weak priceInfoTitledDescriptionView] in
                priceInfoTitledDescriptionView?.setDescriptionLabelTextColor($0 ? .green : .red)
            }
            .store(in: &cancellables)
    }
    
    func setupData(with viewModel: ViewModel) {
        nameTitledDescriptionView.viewModel = viewModel.nameTitledDescriptionViewModel
        priceInfoTitledDescriptionView.viewModel = viewModel.priceInfoTitledDescriptionViewModel
        
        priceInfoTitledDescriptionView.setTextAlignment(to: .right)
        
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        viewModel = nil
    }
}

//
//  NetworthCoinCell.swift
//  CoinGecko
//
//  Created by Max Sashcheka on 30.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import SnapKit
import Utils

final class NetworthCoinCell: TableCell {
    private typealias Colors = AppStyle.Colors.Home.CoinCell
    
    // MARK: - Properties
    
    private let containerShadowView: View = {
        let view = View(shadowColor: Colors.shadow,
                        shadowOffset: .zero,
                        shadowRadius: 3.0,
                        shadowOpacity: 1)
        view.backgroundColor = Colors.shadowBackground
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
    
    private let networthTitledDescriptionView = TitledDescriptionView()
    
    private let deleteButton: Button = {
        let button = Button()
        button.backgroundColor = Colors.deleteButton
        button.setTitle(L10n.Home.NetworthCell.DeleteButton.title, for: .normal)
        button.apply(AppStyle.TextStyles.NetworthCoin.deleteButton)
        button.cornerRadius = 17.5
        
        return button
    }()
    
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
    
    private func arrangeSubviews() {
        contentView.addSubview(containerShadowView)
        containerShadowView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.bottom.equalToSuperview().inset(7.5)
        }
        
        containerShadowView.addSubview(coinImageView)
        coinImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.top.equalToSuperview().inset(15)
            make.size.equalTo(65)
        }
        
        containerShadowView.addSubview(nameTitledDescriptionView)
        nameTitledDescriptionView.snp.makeConstraints { make in
            make.leading.equalTo(coinImageView.snp.trailing).offset(9)
            make.trailing.equalToSuperview().offset(-50)
            make.centerY.equalTo(coinImageView)
        }
        
        containerShadowView.addSubview(priceInfoTitledDescriptionView)
        priceInfoTitledDescriptionView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-15)
            make.centerY.equalTo(nameTitledDescriptionView)
        }
        
        containerShadowView.addSubview(networthTitledDescriptionView)
        networthTitledDescriptionView.snp.makeConstraints { make in
            make.top.equalTo(coinImageView.snp.bottom).offset(15)
            make.leading.equalTo(coinImageView)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        containerShadowView.addSubview(deleteButton)
        deleteButton.snp.makeConstraints { make in
            make.centerY.equalTo(networthTitledDescriptionView)
            make.trailing.equalTo(priceInfoTitledDescriptionView)
            make.width.equalTo(60)
            make.height.equalTo(35)
        }
    }
    
    private func bindData(with viewModel: ViewModel) {
        viewModel.imageURL
            .bind(to: \.imageURL, on: coinImageView)
            .store(in: &cancellables)
        
        viewModel.isPriceChangePositive
            .map { $0 ? Colors.positiveChange : Colors.negativeChange }
            .sink { [weak priceInfoTitledDescriptionView] in
                priceInfoTitledDescriptionView?.setDescriptionLabelTextColor($0)
            }
            .store(in: &cancellables)
        
        deleteButton.tapPublisher()
            .sink { [weak viewModel] in
                guard let viewModel = viewModel else { return }
                viewModel.deleteSubject.send(viewModel.id)
            }
            .store(in: &cancellables)
    }
    
    private func setupData(with viewModel: ViewModel) {
        nameTitledDescriptionView.viewModel = viewModel.nameTitledDescriptionViewModel
        priceInfoTitledDescriptionView.viewModel = viewModel.priceInfoTitledDescriptionViewModel
        networthTitledDescriptionView.viewModel = viewModel.networthTitledDescriptionViewModel
        
        priceInfoTitledDescriptionView.setTextAlignment(to: .right)
        
        selectionStyle = .none
        backgroundColor = Colors.background
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        viewModel = nil
    }
}

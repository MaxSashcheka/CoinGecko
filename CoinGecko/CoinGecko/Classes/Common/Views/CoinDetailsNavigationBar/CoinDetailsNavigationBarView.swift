//
//  CoinDetailsNavigationBarView.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 18.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import SafeSFSymbols
import SnapKit
import Utils

final class CoinDetailsNavigationBarView: View {
    
    // MARK: - Properties
    
    private let closeButton = Button(image: Assets.Images.cross.image)
    
    private let titleLabel = Label(textPreferences: .title)
    
    private let descriptionLabel: Label = {
        let label = Label()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .darkGray
        
        return label
    }()
    
    private let coinImageView: RemoteImageView = {
        let imageView = RemoteImageView(placeholder: .color(.gray))
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let favouriteButton = Button()
    
    private let separatorLine = View(backgroundColor: .lightGray.withAlphaComponent(0.7))
    
    var viewModel: ViewModel? {
        didSet {
            cancellables.removeAll()
            guard let viewModel = viewModel else { return }

            arrangeSubviews()
            bindData(with: viewModel)
            setupData()
        }
    }
    
    // MARK: - Methods
    
    func arrangeSubviews() {
        addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(25)
            make.centerY.equalToSuperview()
            make.size.equalTo(20)
        }
        
        let infoContainerView = View()
        addSubview(infoContainerView)
        infoContainerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        infoContainerView.addSubview(coinImageView)
        coinImageView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.size.equalTo(30)
        }
        
        infoContainerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(coinImageView)
            make.leading.equalTo(coinImageView.snp.trailing).offset(5)
        }
        
        infoContainerView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(3)
            make.bottom.equalTo(titleLabel).offset(-3)
            make.trailing.equalToSuperview()
        }
        
        addSubview(favouriteButton)
        favouriteButton.snp.makeConstraints { make in
            make.centerY.equalTo(closeButton)
            make.trailing.equalToSuperview().offset(-25)
            make.size.equalTo(30)
        }
        
        addSubview(separatorLine)
        separatorLine.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    func bindData(with viewModel: ViewModel) {
        viewModel.title
            .bind(to: \.text, on: titleLabel)
            .store(in: &cancellables)
        
        viewModel.description
            .bind(to: \.text, on: descriptionLabel)
            .store(in: &cancellables)
        
        viewModel.imageURL
            .bind(to: \.imageURL, on: coinImageView)
            .store(in: &cancellables)
        
        viewModel.isFavourite
            .sink { [weak favouriteButton] in
                favouriteButton?.setImage($0 ? UIImage(.heart.fill) : UIImage(.heart), for: .normal)
            }
            .store(in: &cancellables)

        closeButton.tapPublisher()
            .bind(to: viewModel.closeButtonSubject)
            .store(in: &cancellables)
        
        favouriteButton.tapPublisher()
            .bind(to: viewModel.addToFavouriteSubject)
            .store(in: &cancellables)
    }
    
    func setupData() {
        backgroundColor = .white
    }
}

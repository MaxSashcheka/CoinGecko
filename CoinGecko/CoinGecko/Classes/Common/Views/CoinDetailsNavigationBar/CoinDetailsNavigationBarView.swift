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
    private typealias TextStyles = AppStyle.TextStyles.CoinDetails.NavigationBar
    private typealias Colors = AppStyle.Colors.CoinDetails.NavigationBar
    private typealias Images = Assets.Images
    
    // MARK: - Properties
    
    private let closeButton = Button(image: Images.cross.image)
    
    private let titleLabel: Label = .make {
        $0.apply(TextStyles.title)
    }
    
    private let coinImageView: RemoteImageView = {
        let imageView = RemoteImageView(placeholder: .color(.gray))
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let browserButton = Button(image: UIImage(.network))
    
    private let separatorLine = View(backgroundColor: .lightGray.withAlphaComponent(0.7))
    
    var rightBarButtons: [Button] { [browserButton] }
    
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
            make.trailing.equalToSuperview()
        }
        
        let rightBarButtonsStackView = UIStackView(axis: .horizontal, spacing: 10, distribution: .fillEqually)
        addSubview(rightBarButtonsStackView)
        rightBarButtonsStackView.addArrangedSubviews(rightBarButtons)
        
        rightBarButtons.forEach {
            $0.snp.makeConstraints { make in
                make.size.equalTo(30)
            }
        }
  
        rightBarButtonsStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-25)
            make.centerY.equalToSuperview()
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
        
        viewModel.imageURL
            .bind(to: \.imageURL, on: coinImageView)
            .store(in: &cancellables)

        closeButton.tapPublisher()
            .bind(to: viewModel.closeButtonSubject)
            .store(in: &cancellables)
        
        browserButton.tapPublisher()
            .bind(to: viewModel.browserButtonSubject)
            .store(in: &cancellables)
    }
    
    func setupData() {
        backgroundColor = Colors.background
    }
}

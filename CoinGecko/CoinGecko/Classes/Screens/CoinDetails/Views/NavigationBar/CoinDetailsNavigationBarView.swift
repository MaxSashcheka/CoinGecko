//
//  CoinDetailsNavigationBarView.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 18.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import RxCocoa
import RxSwift
import SnapKit
import Utils

extension CoinDetailsViewController {
    final class CoinDetailsNavigationBarView: View {
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
        
        private let separatorLine = View(backgroundColor: .lightGray.withAlphaComponent(0.7))
        
        private var disposeBag = DisposeBag()
        
        var viewModel: ViewModel? {
            didSet {
                disposeBag = DisposeBag()
                guard let viewModel = viewModel else { return }

                arrangeSubviews()
                bindData(with: viewModel)
                setupData()
            }
        }
        
        func arrangeSubviews() {
            addSubview(closeButton)
            closeButton.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(25)
                make.centerY.equalToSuperview()
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
            
            addSubview(separatorLine)
            separatorLine.snp.makeConstraints { make in
                make.leading.trailing.bottom.equalToSuperview()
                make.height.equalTo(1)
            }
        }
        
        func bindData(with viewModel: ViewModel) {
            viewModel.title
                .asDriver()
                .drive(titleLabel.rx.text)
                .disposed(by: disposeBag)
            
            viewModel.description
                .asDriver()
                .drive(descriptionLabel.rx.text)
                .disposed(by: disposeBag)
            
            viewModel.imageURL
                .asDriver()
                .drive(onNext: { [weak self] in
                    self?.coinImageView.imageURL = $0
                })
                .disposed(by: disposeBag)
            
            closeButton.rx.tap
                .asDriver()
                .drive(viewModel.closeButtonRelay)
                .disposed(by: disposeBag)
        }
        
        func setupData() {
            backgroundColor = .white
        }
        
    }
}

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
            
            addSubview(titleLabel)
            titleLabel.snp.makeConstraints { make in
                make.centerX.centerY.equalToSuperview()
            }
            
            addSubview(coinImageView)
            coinImageView.snp.makeConstraints { make in
                make.leading.equalTo(titleLabel.snp.trailing).offset(10)
                make.centerY.equalTo(titleLabel)
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
                .asDriver()
                .drive(titleLabel.rx.text)
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
            
            // TODO: - Move or remove
            separatorLine.layer.shadowColor = UIColor.black.withAlphaComponent(0.25).cgColor
            separatorLine.layer.shadowOffset = CGSize(width: 0, height: 2)
            separatorLine.layer.shadowRadius = 1.5
            separatorLine.layer.shadowOpacity = 1
        }
        
    }
}

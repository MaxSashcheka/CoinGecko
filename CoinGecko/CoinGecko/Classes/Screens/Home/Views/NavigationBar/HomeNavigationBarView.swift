//
//  HomeNavigationBarView.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 28.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import SafeSFSymbols
import SnapKit
import Utils

extension HomeViewController {
    final class HomeNavigationBarView: View {
        private typealias Texts = L10n.Home.NavigationBar.Title
        private typealias TextStyles = AppStyle.TextStyles.Home.NavigationBar
        
        private let welcomeTitleLabel: Label = .make {
            $0.apply(TextStyles.welcomeTitle)
            $0.text = Texts.welcome
        }
        
        private let nameTitleLabel: Label = .make {
            $0.apply(TextStyles.nameTitle)
            $0.text = Texts.name
        }
        
        private let emailTitleLabel: Label = .make {
            $0.apply(TextStyles.emailTitle)
            $0.text = Texts.email
        }
        
        private let settingsButton: Button = .make {
            $0.setImage(Assets.Images.settings.image.withRenderingMode(.alwaysTemplate), for: .normal)
            $0.tintColor = .darkGray
        }
        
        private let profileButton: Button = .make {
            $0.setImage(UIImage(.person.cropCircle), for: .normal)
            $0.tintColor = .darkGray
        }
        
        private let separatorLine = View(backgroundColor: .lightGray.withAlphaComponent(0.7))
        
        var viewModel: ViewModel? {
            didSet {
                cancellables.removeAll()
                guard let viewModel = viewModel else { return }
                
                arrangeSubviews()
                bindData(with: viewModel)
            }
        }
        
        func arrangeSubviews() {
            let titlesStackView = UIStackView(axis: .vertical,
                                              spacing: 5,
                                              distribution: .fill)
            titlesStackView.addArrangedSubviews([welcomeTitleLabel, nameTitleLabel, emailTitleLabel])
            titlesStackView.setCustomSpacing(.zero, after: nameTitleLabel)
            
            addSubview(titlesStackView)
            titlesStackView.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(15)
                make.top.equalToSuperview().offset(47)
                make.bottom.equalToSuperview().offset(-5)
            }
            
            let barButtonsStackView = UIStackView(axis: .horizontal,
                                                  spacing: 15,
                                                  distribution: .fillEqually)
            barButtonsStackView.addArrangedSubviews([profileButton, settingsButton])
            
            addSubview(barButtonsStackView)
            barButtonsStackView.snp.makeConstraints { make in
                make.top.equalTo(titlesStackView)
                make.trailing.equalToSuperview().offset(-20)
            }
            
            profileButton.snp.makeConstraints { make in
                make.size.equalTo(33)
            }
            
            addSubview(separatorLine)
            separatorLine.snp.makeConstraints { make in
                make.leading.trailing.bottom.equalToSuperview()
                make.height.equalTo(1)
            }
        }
        
        func bindData(with viewModel: ViewModel) {
            profileButton.tapPublisher()
                .bind(to: viewModel.profileButtonSubject)
                .store(in: &cancellables)
            
            settingsButton.tapPublisher()
                .bind(to: viewModel.settingsButtonSubject)
                .store(in: &cancellables)
        }
    }
}

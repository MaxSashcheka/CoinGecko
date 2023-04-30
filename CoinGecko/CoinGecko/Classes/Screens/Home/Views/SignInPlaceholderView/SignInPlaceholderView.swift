//
//  SignInPlaceholderView.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 24.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import SafeSFSymbols
import SnapKit
import Utils

extension HomeViewController {
    final class SignInPlaceholderView: View {
        private typealias Texts = L10n.Home.Placeholder
        
        // MARK: - UI Components
        
        private let titleLabel: Label = .make {
            $0.textColor = Assets.Colors.black.color
            $0.font = .systemFont(ofSize: 25, weight: .semibold)
            $0.text = Texts.title
            $0.textAlignment = .center
        }
        
        private let descriptionLabel: Label = .make {
            $0.textColor = Assets.Colors.darkGray.color
            $0.font = .systemFont(ofSize: 23, weight: .regular)
            $0.text = Texts.description
            $0.numberOfLines = .zero
            $0.textAlignment = .center
        }
        
        private let signInButton: Button = .make {
            $0.setTitle(Texts.signIn, for: .normal)
        }
        
        private let signUpButton: Button = .make {
            $0.setTitle(Texts.signUp, for: .normal)
        }
        
        var buttons: [Button] { [signInButton, signUpButton] }
        
        var viewModel: ViewModel? {
            didSet {
                cancellables.removeAll()
                guard let viewModel = viewModel else { return }
                
                arrangeSubviews()
                bindData(with: viewModel)
                setupData()
            }
        }
    }
}

// MARK: - SignInPlaceholderView+Setup
private extension HomeViewController.SignInPlaceholderView {
    func bindData(with viewModel: ViewModel) {
        signInButton.tapPublisher
            .map { ViewModel.Mode.signIn }
            .bind(to: viewModel.tapSubject)
            .store(in: &cancellables)
        
        signUpButton.tapPublisher
            .map { ViewModel.Mode.signUp }
            .bind(to: viewModel.tapSubject)
            .store(in: &cancellables)
    }
    
    func arrangeSubviews() {
        addSubviews([titleLabel, descriptionLabel])
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        let buttonsStackView = UIStackView(axis: .vertical, spacing: 10, distribution: .fillEqually)
        buttonsStackView.addArrangedSubviews(buttons)
        addSubview(buttonsStackView)
        buttonsStackView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        buttons.forEach {
            $0.snp.makeConstraints { make in
                make.height.equalTo(50)
            }
        }
    }
    
    func setupData() {
        buttons.forEach {
            $0.backgroundColor = Assets.Colors.blue.color.withAlphaComponent(0.7)
            $0.cornerRadius = 25
        }
    }
}

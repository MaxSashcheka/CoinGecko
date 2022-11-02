//
//  SearchTextField.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 9.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import UIKit
import Utils

final class SearchTextField: View {
    private let innerTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search Cryptocurrency"
        
        return textField
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Assets.Images.search.image.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .lightGray.withAlphaComponent(0.7)

        return imageView
    }()
    
    private let clearButton: Button = {
        let button = Button()
        button.setImage(Assets.Images.cross.image.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .lightGray.withAlphaComponent(0.7)
        button.alpha = .zero
        
        return button
    }()
    
    var viewModel: ViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            bindData(with: viewModel)
            arrangeSubviews()
        }
    }
    
    override func initialize() {
        arrangeSubviews()
        
        backgroundColor = .white
        cornerRadius = 8
        borderColor = .lightGray.withAlphaComponent(0.7)
        borderWidth = 1.5
        
        innerTextField.delegate = self
    }
    
    private func bindData(with viewModel: ViewModel) {
        innerTextField.textPublisher()
            .sink { [weak self] query in
                self?.viewModel?.updateQuery(with: query)
                UIView.animate(withDuration: 0.15) {
                    self?.clearButton.alpha = query.isEmpty ? 0 : 1
                }
            }
            .store(in: &cancellables)
        
        clearButton.tapPublisher()
            .sink { [weak self] in
                self?.innerTextField.text = .empty
                UIView.animate(withDuration: 0.15) {
                    self?.clearButton.alpha = 0
                }
            }
            .store(in: &cancellables)
    }
    
    private func arrangeSubviews() {
        addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.size.equalTo(18)
            make.centerY.equalToSuperview()
        }

        addSubview(innerTextField)
        innerTextField.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(5)
            make.top.bottom.equalToSuperview().inset(5)
            make.trailing.equalToSuperview().offset(-30)
        }

        addSubview(clearButton)
        clearButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.size.equalTo(20)
        }
    }
}

extension SearchTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewModel?.didTapReturnButton()
        return true
    }
}

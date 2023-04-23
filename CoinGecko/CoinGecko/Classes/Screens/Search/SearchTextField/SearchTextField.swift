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
    private typealias Colors = AppStyle.Colors.Search.TextField
    
    // MARK: - Properties
    
    private let innerTextField: UITextField = .make {
        $0.placeholder = L10n.Search.TextField.Placeholder.title
    }
    
    private let iconImageView: UIImageView = .make {
        $0.image = Assets.Images.search.image.withRenderingMode(.alwaysTemplate)
        $0.tintColor = Colors.tint
    }
    
    private let clearButton: Button = .make {
        $0.setImage(Assets.Images.cross.image.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = Colors.tint
        $0.alpha = .zero
    }
    
    var viewModel: ViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            bindData(with: viewModel)
            arrangeSubviews()
        }
    }
    
    // MARK: - Methods
    
    override func initialize() {
        arrangeSubviews()
        
        backgroundColor = .white
        cornerRadius = 8
        borderColor = Colors.tint
        borderWidth = 1.5
        
        innerTextField.delegate = self
    }
    
    private func bindData(with viewModel: ViewModel) {
        innerTextField.textPublisher
            .sink { [weak self] query in
                self?.viewModel?.updateQuery(with: query)
                UIView.animate(withDuration: 0.15) {
                    self?.clearButton.alpha = query.isEmpty ? .zero : 1
                }
            }
            .store(in: &cancellables)
        
        clearButton.tapPublisher()
            .sink { [weak self] in
                self?.innerTextField.text = .empty
                UIView.animate(withDuration: 0.15) {
                    self?.clearButton.alpha = .zero
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

// MARK: - SearchTextField+UITextFieldDelegate
extension SearchTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewModel?.didTapReturnButton()
        return true
    }
}

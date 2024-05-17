//
//  TitledTextField.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 16.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import SnapKit
import Utils

final class TitledTextField: View {
    private typealias Colors = Assets.Colors
    
    private let titleLabel: Label = .make {
        $0.font = .systemFont(ofSize: 20, weight: .medium)
        $0.text = "Write username"
    }
    
    private let textField: UITextField = .make {
        $0.tintColor = Assets.Colors.black.color
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 18, weight: .medium)
    }
    
    private let separatorLine = View(backgroundColor: Assets.Colors.lightGray.color)
    
    private let hintLabel: Label = .make {
        $0.font = .systemFont(ofSize: 15, weight: .medium)
        $0.textColor = Assets.Colors.red.color
        $0.isHidden = true
    }
    
    override var isFirstResponder: Bool { textField.isFirstResponder }
    
    var viewModel: ViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            cancellables.removeAll()
            
            bindData(with: viewModel)
            arrangeSubviews()
        }
    }
    
    func setTextInputTraitsOptions(_ options: [TextInputTraitsOptions]) {
        textField.textInputTraitsOptions = options
    }
}

private extension TitledTextField {
    func bindData(with viewModel: ViewModel) {
        textField.textPublisher
            .sink { [weak viewModel] in
                viewModel?.didEnterText($0)
            }
            .store(in: &cancellables)
        
        viewModel.title
            .bind(to: \.text, on: titleLabel)
            .store(in: &cancellables)
        
        viewModel.errorHintText
            .bind(to: \.text, on: hintLabel)
            .store(in: &cancellables)
        
        viewModel.isErrorVisible
            .map { $0 ? Colors.red.color : Colors.lightGray.color }
            .sink { [weak self] color in
                UIView.animate(withDuration: 0.33) { self?.separatorLine.backgroundColor = color }
            }
            .store(in: &cancellables)
        
        viewModel.isErrorVisible
            .map(!)
            .bind(to: \.isHidden, on: hintLabel)
            .store(in: &cancellables)
        
        viewModel.isSecureTextEntry
            .bind(to: \.isSecureTextEntry, on: textField)
            .store(in: &cancellables)
    }
    
    func arrangeSubviews() {
        backgroundColor = .clear
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.top.equalToSuperview()
        }
        
        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
        }
        
        addSubview(separatorLine)
        separatorLine.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom)
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview()
        }
        
        addSubview(hintLabel)
        hintLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(separatorLine.snp.bottom).offset(3)
            make.bottom.equalToSuperview()
        }
    }
}

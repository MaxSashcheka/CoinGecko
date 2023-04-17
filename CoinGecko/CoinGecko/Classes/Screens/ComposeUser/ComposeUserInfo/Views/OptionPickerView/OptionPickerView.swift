//
//  OptionPickerView.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 17.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import SnapKit
import Utils

final class OptionPickerView: View {
    private let titleLabel: Label = .make {
        $0.font = .systemFont(ofSize: 20, weight: .medium)
        $0.numberOfLines = .zero
        $0.textAlignment = .center
    }
    
    private let buttonsStackView: UIStackView = .make {
        $0.axis = .horizontal
        $0.spacing = 40
    }
    
    private let yesButton = Button()
    
    private let noButton = Button()
    
    var viewModel: ViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            cancellables.removeAll()
            
            bindData(with: viewModel)
            arrangeSubviews()
        }
    }
    
    override func initialize() {
        super.initialize()
        
        yesButton.setTitle("YES", for: .normal)
        noButton.setTitle("NO", for: .normal)
        
        [yesButton, noButton].forEach {
            $0.setTitleColor(Assets.Colors.black.color.withAlphaComponent(0.3), for: .normal)
            $0.setTitleColor(Assets.Colors.black.color, for: .selected)
        }
    }
}

private extension OptionPickerView {
    func bindData(with viewModel: ViewModel) {
        viewModel.title
            .bind(to: \.text, on: titleLabel)
            .store(in: &cancellables)
        
        yesButton.tapPublisher()
            .map { true }
            .bind(to: viewModel.selectedOption)
            .store(in: &cancellables)
        
        noButton.tapPublisher()
            .map { false }
            .bind(to: viewModel.selectedOption)
            .store(in: &cancellables)
        
        viewModel.selectedOption
            .map { $0 == true }
            .bind(to: \.isSelected, on: yesButton)
            .store(in: &cancellables)
        
        viewModel.selectedOption
            .map { $0 == false }
            .bind(to: \.isSelected, on: noButton)
            .store(in: &cancellables)

    }
    
    func arrangeSubviews() {
        backgroundColor = .white
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.top.equalToSuperview()
        }
        
        addSubview(buttonsStackView)
        buttonsStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-5)
        }
        
        buttonsStackView.addArrangedSubviews([yesButton, noButton])
    }
}

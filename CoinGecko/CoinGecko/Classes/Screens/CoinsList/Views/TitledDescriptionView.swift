//
//  TitledDescriptionView.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 17.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import UIKit
import Utils

final class TitledDescriptionView: View {
    
    // MARK: - Properties
    
    private let titleLabel = Label(textPreferences: .title)
    
    private let descriptionLabel = Label(textPreferences: .subtitle)
    
    var viewModel: ViewModel? {
        didSet {
            cancellables.removeAll()
            guard let viewModel = viewModel else { return }
            
            arrangeSubviews()
            bindData(with: viewModel)
        }
    }
    
    // MARK: - Methods
    
    func arrangeSubviews() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
        }
        
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
    }
    
    func bindData(with viewModel: ViewModel) {
        viewModel.titleText
            .bind(to: \.text, on: titleLabel)
            .store(in: &cancellables)
        
        viewModel.descriptionText
            .bind(to: \.text, on: descriptionLabel)
            .store(in: &cancellables)
    }
}

// MARK: - TitledDescriptionView+SetValues
extension TitledDescriptionView {
    func setTextAlignment(to textAlignment: NSTextAlignment) {
        titleLabel.textAlignment = textAlignment
        descriptionLabel.textAlignment = textAlignment
    }
    
    func setDescriptionLabelTextColor(_ color: UIColor) {
        descriptionLabel.textColor = color
    }
}

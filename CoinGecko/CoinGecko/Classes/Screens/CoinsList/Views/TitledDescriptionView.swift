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
    private let titleLabel = Label(textPreferences: .title)
    private let descriptionLabel = Label(textPreferences: .subtitle)
    
    var viewModel: ViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            arrangeSubviews()
            setupData(with: viewModel)
        }
    }
    
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
    
    func setupData(with viewModel: ViewModel) {
        titleLabel.text = viewModel.titleText
        descriptionLabel.text = viewModel.descriptionText
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

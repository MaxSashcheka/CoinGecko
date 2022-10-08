//
//  PageButton.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 2.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import UIKit
import Utils
import SnapKit

final class PageButton: Button {
    private let bottomLine = View(backgroundColor: .blue)
    
    var viewModel: ViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            cancellables.removeAll()
            
            bindData(with: viewModel)
            arrangeSubviews()
            
            font = .systemFont(ofSize: 20, weight: .medium)
            textColor = .darkGray
            
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bottomLine.layer.cornerRadius = bottomLine.layer.frame.height / 2
    }
    
    private func arrangeSubviews() {
        addSubview(bottomLine)
        bottomLine.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(2)
        }
    }
    
    private func bindData(with viewModel: ViewModel) {
        viewModel.title
            .sink { [weak self] in self?.setTitle($0, for: .normal) }
            .store(in: &cancellables)
        
        viewModel.isSelected
            .sink { [weak self] isSelected in
                self?.setTitleColor(isSelected ? .blue : .darkGray, for: .normal)
                self?.bottomLine.isHidden = !isSelected
            }
            .store(in: &cancellables)
    }
}

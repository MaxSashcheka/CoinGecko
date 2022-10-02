//
//  RangePickerButton.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 25.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import UIKit
import Utils

class RangePickerButton: Button {    
    var viewModel: ViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            cancellables.removeAll()
            
            bindData(with: viewModel)
        }
    }
    
    private func bindData(with viewModel: ViewModel) {
        viewModel.title
            .sink { [weak self] in self?.setTitle($0, for: .normal) }
            .store(in: &cancellables)

        viewModel.isSelected
            .sink { [weak self] in self?.isSelected = $0 }
            .store(in: &cancellables)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initialize()
    }
    
    override var intrinsicContentSize: CGSize {
        let originalIntrinsicContentSize = super.intrinsicContentSize
        let width = originalIntrinsicContentSize.width + 10

        return .init(width: width, height: originalIntrinsicContentSize.height)
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundColor = .systemBlue.withAlphaComponent(0.1)
                setTitleColor(.systemBlue.withAlphaComponent(0.7), for: .normal)
                layer.borderColor = UIColor.systemBlue.withAlphaComponent(0.7).cgColor
            } else {
                backgroundColor = .lightGray.withAlphaComponent(0.15)
                setTitleColor(.darkGray, for: .normal)
                layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
            }
        }
    }
    
    func initialize() {
        font = .systemFont(ofSize: 15, weight: .semibold)
        backgroundColor = .lightGray.withAlphaComponent(0.15)
        
        setTitleColor(.darkGray, for: .normal)
        
        layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        layer.borderWidth = 1
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cornerRadius = frame.height / 2
    }
}

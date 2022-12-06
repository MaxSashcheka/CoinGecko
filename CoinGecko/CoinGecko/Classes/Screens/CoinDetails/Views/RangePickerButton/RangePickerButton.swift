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
    private typealias Colors = AppStyle.Colors.RangePickerButton
    
    // MARK: - Properties
    
    var viewModel: ViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            cancellables.removeAll()
            
            bindData(with: viewModel)
        }
    }
    
    override var intrinsicContentSize: CGSize {
        let originalIntrinsicContentSize = super.intrinsicContentSize
        let width = originalIntrinsicContentSize.width + 10

        return .init(width: width, height: originalIntrinsicContentSize.height)
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundColor = Colors.Selected.background
                setTitleColor(Colors.Selected.title, for: .normal)
                layer.borderColor = Colors.Selected.border.cgColor
            } else {
                backgroundColor = Colors.Unselected.background
                setTitleColor(Colors.Unselected.title, for: .normal)
                layer.borderColor = Colors.Unselected.border.cgColor
            }
        }
    }
    
    // MARK: - Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cornerRadius = frame.height / 2
    }
    
    private func bindData(with viewModel: ViewModel) {
        viewModel.title
            .sink { [weak self] in
                self?.setTitle($0, for: .normal)
            }
            .store(in: &cancellables)

        viewModel.isSelected
            .bind(to: \.isSelected, on: self)
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
    
    func initialize() {
        apply(AppStyle.TextStyles.CoinDetails.RangePickerButton.title)
        
        backgroundColor = Colors.Unselected.background
        layer.borderColor = Colors.Unselected.border.cgColor
        layer.borderWidth = 1
    }
}

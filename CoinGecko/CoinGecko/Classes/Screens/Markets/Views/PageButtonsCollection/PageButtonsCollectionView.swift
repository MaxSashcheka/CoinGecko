//
//  PageButtonsCollectionView.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 2.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import SnapKit
import Utils

final class PageButtonsCollectionView: View {
    
    // MARK: - Properties
    
    private let stackView = UIStackView(axis: .horizontal,
                                        spacing: 15,
                                        distribution: .equalSpacing)
    
    private var buttons = [PageButton]() {
        didSet {
            bindButtons()
        }
    }
    
    var viewModel: ViewModel? {
        didSet {
            cancellables.removeAll()
            guard let viewModel = viewModel else { return }
            
            bindData(with: viewModel)
            arrangeSubviews()
            setupData()
        }
    }
    
    // MARK: - Methods
    
    private func arrangeSubviews() {
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func bindData(with viewModel: ViewModel) {
        viewModel.buttonsViewModels
            .sink { [weak self, weak viewModel] viewModels in
                let buttons = viewModels.map {
                    let button = PageButton()
                    button.viewModel = $0
                    return button
                }
                self?.buttons = buttons
                self?.stackView.addArrangedSubviews(buttons)
                viewModel?.selectButton(at: .zero)
            }
            .store(in: &cancellables)
    }
    
    private func bindButtons() {
        buttons.enumerated().forEach { index, button in
            button.tapPublisher()
                .sink { [weak viewModel] _ in
                    viewModel?.selectButton(at: index)
                    UIFeedbackGenerator.generateFeedback(.medium)
                }
                .store(in: &cancellables)
        }
    }
    
    private func setupData() {
        stackView.isUserInteractionEnabled = true
    }
}

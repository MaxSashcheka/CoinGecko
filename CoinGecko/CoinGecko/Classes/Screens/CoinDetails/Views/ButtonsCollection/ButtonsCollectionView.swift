//
//  ButtonsCollectionView.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 27.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import SnapKit
import Utils

final class ButtonsCollectionView: View {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillProportionally
        
        return stackView
    }()
    
    private var buttons = [Button]() {
        didSet {
            bindButtons()
        }
    }
    
    var viewModel: ViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            cancellables.removeAll()
            
            bindData(with: viewModel)
            arrangeSubviews()
        }
    }
    
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
                    let button = RangePickerButton()
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
                .sink { [weak viewModel] in
                    viewModel?.selectButton(at: index)
                }
                .store(in: &cancellables)
        }
    }
}

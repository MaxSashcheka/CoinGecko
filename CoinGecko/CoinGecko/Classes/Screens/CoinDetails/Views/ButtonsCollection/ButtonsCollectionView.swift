//
//  ButtonsCollectionView.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 27.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import RxCocoa
import RxSwift
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
    
    private var disposeBag = DisposeBag()
    
    var viewModel: ViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            disposeBag = DisposeBag()
            
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
            .asDriver()
            .drive(onNext: { [weak self, weak viewModel] viewModels in
                let buttons = viewModels.map {
                    let button = RangePickerButton()
                    button.viewModel = $0
                    return button
                }
                self?.buttons = buttons
                self?.stackView.addArrangedSubviews(buttons)
                viewModel?.selectButton(at: .zero)
            })
            .disposed(by: disposeBag)
    }
    
    private func bindButtons() {
        buttons.enumerated().forEach { index, button in
            button.rx.tap
                .asDriver()
                .drive(onNext: { [weak viewModel] in
                    viewModel?.selectButton(at: index)
                })
                .disposed(by: disposeBag)
        }
    }
}

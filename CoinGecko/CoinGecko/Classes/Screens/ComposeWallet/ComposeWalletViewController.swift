//
//  ComposeWalletViewController.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 26.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import SafeSFSymbols
import SnapKit
import Utils

final class ComposeWalletViewController: ViewController {
    private typealias Texts = L10n.ComposeWallet
    
    private let nameTitledTextField = TitledTextField()
    
    private let finishButton: Button = .make {
        $0.backgroundColor = Assets.Colors.blue.color.withAlphaComponent(0.7)
        $0.setTitle(Texts.Button.finish, for: .normal)
    }
    
    private let pickColorButton: Button = .make {
        $0.backgroundColor = Assets.Colors.blue.color.withAlphaComponent(0.7)
        $0.setTitle(Texts.Button.pickColor, for: .normal)
    }
    
    private let previewLabel: Label = .make {
        $0.textColor = Assets.Colors.darkGray.color
        $0.font = .systemFont(ofSize: 23, weight: .regular)
        $0.text = Texts.previewTitle
    }
    
    private let walletView = WalletView()
    
    override var backgroundColor: UIColor { Assets.Colors.white.color }
    
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Texts.title
        
        activateEndEditingTap(at: view)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.barButtonItem(
            image: Assets.Images.cross.image,
            action: { [weak viewModel] in viewModel?.didTapCloseButton() }
        )
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        [finishButton, pickColorButton].forEach {
            $0.layer.cornerRadius = $0.bounds.height / 2
        }
    }
    
    override func bindData() {
        super.bindData()
        
        pickColorButton.tapPublisher
            .sink { [weak viewModel] in
                viewModel?.didTapPickColorButton()
            }
            .store(in: &cancellables)
        
        finishButton.tapPublisher
            .sink { [weak viewModel] in
                viewModel?.didTapFinishButton()
            }
            .store(in: &cancellables)
    }
    
    override func arrangeSubviews() {
        super.arrangeSubviews()
        
        view.addSubview(nameTitledTextField)
        nameTitledTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.leading.trailing.equalToSuperview().inset(45)
        }
        
        view.addSubview(previewLabel)
        previewLabel.snp.makeConstraints { make in
            make.top.equalTo(nameTitledTextField.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(walletView)
        walletView.snp.makeConstraints { make in
            make.top.equalTo(previewLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(25)
            make.height.equalTo(100)
        }
        
        view.addSubview(pickColorButton)
        pickColorButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview().inset(45)
            make.top.equalTo(walletView.snp.bottom).offset(30)
        }
        
        view.addSubview(finishButton)
        finishButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview().inset(45)
            make.bottom.equalToSuperview().offset(-50)
        }
    }
    
    override func setupData() {
        super.setupData()
        
        walletView.viewModel = viewModel.walletViewModel
        nameTitledTextField.viewModel = viewModel.nameTitledTextFieldViewModel
    }
}

// MARK: - ComposeWalletViewController+EndEditingTappable
extension ComposeWalletViewController: EndEditingTappable { }

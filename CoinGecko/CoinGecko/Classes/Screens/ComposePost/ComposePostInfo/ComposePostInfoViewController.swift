//
//  ComposePostInfoViewController.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 22.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import SnapKit
import Utils

final class ComposePostInfoViewController: ViewController {
    private typealias Texts = L10n.CreatePost
    
    // MARK: - UI Components
    
    private let contentScrollView = UIScrollView()
    
    private let titleTextField = TitledTextField()
    
    private let contentTitleLabel: Label = .make {
        $0.font = .systemFont(ofSize: 20, weight: .medium)
        $0.text = Texts.Content.title
    }
    
    private let contentTextView: UITextView = .make {
        $0.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        $0.layer.borderColor = Assets.Colors.lightGray.color.cgColor
        $0.textColor = Assets.Colors.darkGray.color
        $0.font = .systemFont(ofSize: 16)
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 12
    }
    
    private let contentHintLabel: Label = .make {
        $0.font = .systemFont(ofSize: 15, weight: .medium)
        $0.textColor = Assets.Colors.red.color
        $0.text = Texts.Content.hint
        $0.isHidden = true
    }
    
    private let continueButton: Button = .make {
        $0.backgroundColor = Assets.Colors.blue.color.withAlphaComponent(0.7)
        $0.setTitle(Texts.continueButton, for: .normal)
    }
    
    override var backgroundColor: UIColor { Assets.Colors.white.color }

    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Texts.title
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.barButtonItem(
            image: Assets.Images.cross.image,
            action: { [weak viewModel] in viewModel?.didTapCloseButton() }
        )
        
        activateEndEditingTap(at: view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1,
                           delay: .zero,
                           usingSpringWithDamping: 0.6,
                           initialSpringVelocity: 2,
                           options: []) {
                self.continueButton.transform = .identity
            } completion: { _ in }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        continueButton.layer.cornerRadius = continueButton.bounds.height / 2
    }
    
    override func arrangeSubviews() {
        super.arrangeSubviews()
     
        view.addSubview(titleTextField)
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalToSuperview().inset(45)
        }
        
        view.addSubview(contentTitleLabel)
        contentTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(contentTextView)
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(contentTitleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(45)
            make.height.equalTo(250)
        }
        
        view.addSubview(contentHintLabel)
        contentHintLabel.snp.makeConstraints { make in
            make.top.equalTo(contentTextView.snp.bottom).offset(3)
            make.centerX.equalToSuperview()
        }

        view.addSubview(continueButton)
        continueButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview().inset(45)
            make.bottom.equalToSuperview().offset(-50)
        }
    }
    
    override func bindData() {
        super.bindData()
        
        continueButton.tapPublisher
            .sink { [weak viewModel] in viewModel?.didTapContinueButton() }
            .store(in: &cancellables)
        
        contentTextView.textPublisher
            .bind(to: viewModel.contentText)
            .store(in: &cancellables)
        
        contentTextView.textPublisher
            .sink { [weak viewModel] in viewModel?.saveContent($0) }
            .store(in: &cancellables)
        
        viewModel.isContentErrorVisible
            .map(!)
            .bind(to: \.isHidden, on: contentHintLabel)
            .store(in: &cancellables)
    }
    
    override func setupData() {
        super.setupData()
        
        titleTextField.viewModel = viewModel.titleTextFieldViewModel
    }
}

// MARK: - ComposePostInfoViewController+EndEditingTappable
extension ComposePostInfoViewController: EndEditingTappable { }

//
//  CoinDetailsViewController.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 18.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import RxCocoa
import RxSwift
import SnapKit
import Utils

final class CoinDetailsViewController: ViewController {
    private let navigationBarView = CoinDetailsNavigationBarView()
    
    private let scrollView = UIScrollView()
    
    private let iconImageView: RemoteImageView = {
        let imageView = RemoteImageView(placeholder: .color(.gray))
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let descriptionTitleLabel = Label(textPreferences: .largeTitle)
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .center
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        textView.font = .systemFont(ofSize: 17, weight: .regular)
        textView.textColor = .gray.withAlphaComponent(0.7)
        
        return textView
    }()
    
    var viewModel: ViewModel!
    
    override var backgroundColor: UIColor { .white }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        descriptionTextView.backgroundColor = .red
    }
    
    override func arrangeSubviews() {
        super.arrangeSubviews()
        
        view.addSubview(navigationBarView)
        navigationBarView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(53)
        }
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(navigationBarView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(25)
            make.size.equalTo(250)
        }
        
        scrollView.addSubview(descriptionTitleLabel)
        descriptionTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
        
        scrollView.addSubview(descriptionTextView)
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(descriptionTitleLabel.snp.bottom).offset(10)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview().offset(-40)
        }
        
    }
    
    override func bindData() {
        super.bindData()
        
        viewModel.navigationBarViewModel.closeButtonRelay
            .asDriver()
            .skip(1)
            .drive(onNext: { [weak viewModel] in
                viewModel?.didTapCloseButton()
            })
            .disposed(by: disposeBag)
        
        viewModel.imageURL
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.iconImageView.imageURL = $0
            })
            .disposed(by: disposeBag)
        
        viewModel.descriptionText
            .asDriver()
            .drive(descriptionTextView.rx.text)
            .disposed(by: disposeBag)

    }
    
    override func setupData() {
        super.setupData()
        
        navigationBarView.viewModel = viewModel.navigationBarViewModel
        descriptionTitleLabel.text = "Description"
    }
}

//
//  PostDetailsViewController.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 22.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import SafeSFSymbols
import SnapKit
import Utils

final class PostDetailsViewController: ViewController {
    
    // MARK: - UI Components
    
    private let contentScrollView: UIScrollView = .make {
        $0.alwaysBounceVertical = true
    }
    
    private let photoImageView = RemoteImageView(placeholder: .color(Assets.Colors.lightGray.color))
    
    private let titleLabel: Label = .make {
        $0.font = .systemFont(ofSize: 25, weight: .semibold)
        $0.numberOfLines = .zero
        $0.textAlignment = .center
    }
    
    private let contentLabel: Label = .make {
        $0.font = .systemFont(ofSize: 20, weight: .medium)
        $0.numberOfLines = .zero
        $0.textColor = Assets.Colors.darkGray.color
    }
    
    override var backgroundColor: UIColor { Assets.Colors.white.color }
    
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Post Details"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.barButtonItem(
            image: Assets.Images.cross.image,
            action: { [weak viewModel] in viewModel?.didTapCloseButton() }
        )
        
        viewModel.errorHandlerClosure = errorHandler
    }
    
    override func arrangeSubviews() {
        super.arrangeSubviews()
        
        view.addSubview(contentScrollView)
        contentScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentScrollView.addSubviews([photoImageView, titleLabel, contentLabel])
        
        photoImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(photoImageView.snp.width)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-40)
        }
    }
    
    override func bindData() {
        super.bindData()
        
        viewModel.imageURL
            .bind(to: \.imageURL, on: photoImageView)
            .store(in: &cancellables)
        
        viewModel.titleText
            .bind(to: \.text, on: titleLabel)
            .store(in: &cancellables)
        
        viewModel.contentText
            .bind(to: \.text, on: contentLabel)
            .store(in: &cancellables)
    }
}

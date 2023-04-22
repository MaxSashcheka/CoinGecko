//
//  HomeViewController.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 10.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import SafeSFSymbols
import SnapKit
import Utils

final class HomeViewController: ViewController {
    private typealias Texts = L10n.Home.Placeholder
    private typealias TextStyles = AppStyle.TextStyles.Home.Placeholder
    private typealias Colors = AppStyle.Colors.Home
    
    // MARK: - Properties
    
    override var backgroundColor: UIColor { Colors.background }
    override var tabBarTitle: String { L10n.Tabbar.Title.home }
    override var tabBarImage: UIImage? { UIImage(.house) }
    
    var viewModel: ViewModel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.errorHandlerClosure = errorHandler
    }
    
    // MARK: - Methods
    
    override func arrangeSubviews() {
        super.arrangeSubviews()
        

    }
    
    override func bindData() {
        super.bindData()
        
    }
    
    override func setupData() {
        super.setupData()
    
    }
}

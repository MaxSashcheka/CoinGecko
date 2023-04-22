//
//  NewsListViewController.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 22.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import SafeSFSymbols
import SnapKit
import Utils

final class NewsListViewController: ViewController {
    
    override var backgroundColor: UIColor { .red }
    override var tabBarTitle: String { "News" }
    override var tabBarImage: UIImage? { UIImage(.newspaper) }
    
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "News"
        
        viewModel.errorHandlerClosure = errorHandler
    }
}

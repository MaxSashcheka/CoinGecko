//
//  MarketsViewController.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 1.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import UIKit
import Utils

final class MarketsViewController: ViewController {
    
    var viewModel: ViewModel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Hello"
        navigationController?.tabBarItem.title = "Markets"
        navigationController?.tabBarItem.image = UIImage(systemName: "chart.xyaxis.line")
    }
}

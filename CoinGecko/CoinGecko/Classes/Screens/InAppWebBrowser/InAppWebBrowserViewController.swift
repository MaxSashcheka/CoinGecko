//
//  RootCoordinator.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 07.12.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import SafariServices

final class InAppWebBrowserViewController: SFSafariViewController {
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
    }
}

extension InAppWebBrowserViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        viewModel.didSafariViewControllerFinished()
    }
}

//
//  ComposePostPhotoViewController.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 23.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

final class ComposePostPhotoViewController: BaseComposePhotoViewController<ComposePostPhotoViewModel> {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Texts.Title.createPost
    }
}

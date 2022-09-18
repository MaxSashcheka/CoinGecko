//
//  RemoteImageView.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 17.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Utils
import UIKit.UIImageView

final class RemoteImageView: UIImageView, RemoteImageDownloadable {
    var imageURL: URL? {
        didSet {
            didUpdateImageURL()
        }
    }
    
    let placeholder: RemoteImagePlaceholder?
    let imageBackgroundColor: UIColor?
    
    var didDownloadImage: Closure.Void?
    var didFinishImageTransition: Closure.Void?

    init(imageURL: URL? = nil,
         placeholder: RemoteImagePlaceholder? = nil,
         backgroundColor: UIColor? = nil,
         contentMode: UIView.ContentMode = .scaleToFill) {
        self.imageURL = imageURL
        self.placeholder = placeholder
        self.imageBackgroundColor = backgroundColor
        
        super.init(frame: .zero)
        
        self.contentMode = contentMode
        didUpdateImageURL()
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

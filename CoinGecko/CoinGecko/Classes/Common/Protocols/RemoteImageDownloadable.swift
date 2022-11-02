//
//  RemoteImageDownloadable.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 17.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import SDWebImage
import Utils

/// Placeholder to show when image is loading
enum RemoteImagePlaceholder {
    case image(UIImage)
    case color(UIColor)
}

protocol RemoteImageDownloadable: UIImageView {
    var imageURL: URL? { get set }
    var placeholder: RemoteImagePlaceholder? { get }
    var imageBackgroundColor: UIColor? { get }
    
    var didDownloadImage: Closure.Void? { get set }
    var didFinishImageTransition: Closure.Void? { get set }
    
    init(imageURL: URL?,
         placeholder: RemoteImagePlaceholder?,
         backgroundColor: UIColor?,
         contentMode: ContentMode)
}

extension RemoteImageDownloadable {
    func cancelCurrentImageLoad() {
        sd_cancelCurrentImageLoad()
    }
    
    func didUpdateImageURL() {
        if imageURL != nil {
            setupImageTransition()
        }
        sd_setImage(
            with: imageURL,
            placeholderImage: getPlaceholderImageIfExist(placeholder),
            completed: { [weak self] _, _, _, _ in
                self?.didDownloadImage?()
            }
        )
    }
    
    private func getPlaceholderImageIfExist(_ placeholder: RemoteImagePlaceholder?) -> UIImage? {
        switch placeholder {
        case .image(let image):
            return image
        case .color(let color):
            let view = UIView()
            view.backgroundColor = color
            view.frame.size = intrinsicContentSize
            return view.asImage()
        case .none:
            return nil
        }
    }
    
    private func setupImageTransition() {
        let transition = SDWebImageTransition.fade(duration: 0.2)
        transition.completion = { [weak self] _ in
            self?.didFinishImageTransition?()
        }
        sd_imageTransition = transition
    }
}



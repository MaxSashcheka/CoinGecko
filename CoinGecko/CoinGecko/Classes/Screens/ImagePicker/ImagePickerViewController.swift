//
//  ImagePickerViewController.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 17.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import UIKit

final class ImagePickerViewController: UIImagePickerController {
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sourceType = .photoLibrary
        delegate = self
        allowsEditing = true
    }
}

extension ImagePickerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        guard let image = info[.originalImage] as? UIImage else { return }
        
        viewModel.didFinishPickingImage(image)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        viewModel.transitions.close()
    }
}

//
//  FirebaseProvider.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 19.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import FirebaseStorage
import Utils
import UIKit

final class FirebaseProvider {
    func uploadImage(image: UIImage,
                     success: @escaping Closure.String,
                     failure: @escaping Closure.GeneralError) {
        let storageRef = Storage.storage().reference()
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }

        let path = "images/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(path)

        let uploadTask = fileRef.putData(imageData, metadata: nil) { metaData, error in
            if error.isNil && !metaData.isNil {
                fileRef.downloadURL(completion: { url, error in
                    guard let url = url else { return }
                    success(url.absoluteString)
                })

            }
        }
    }
}

//
//  FirebaseProvider.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 19.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Core
import FirebaseStorage
import UIKit
import Utils

final class FirebaseProvider {
    func uploadImage(image: UIImage,
                     success: @escaping Closure.String,
                     failure: @escaping Closure.FirebaseError) {
        let storageRef = Storage.storage().reference()
        
        guard let imageData = image.jpegData(compressionQuality: 0.6) else { return }

        let path = "images/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(path)

        _ = fileRef.putData(imageData, metadata: nil) { metaData, error in
            guard error.isNil else {
                failure(
                    FirebaseError(code: .uploadImage, underlying: error)
                )
                return
            }
            guard !metaData.isNil else {
                failure(
                    FirebaseError(code: .uploadImage, message: "Metadata should not be empty")
                )
                return
            }
            
            fileRef.downloadURL(completion: { url, error in
                guard let url = url else {
                    failure(
                        FirebaseError(code: .uploadImage, message: "Image url should not be nil")
                    )
                    return
                }
                guard error.isNil else {
                    failure(
                        FirebaseError(code: .uploadImage, underlying: error)
                    )
                    return
                }
                success(url.absoluteString)
            })
        }
    }
}

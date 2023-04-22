//
//  FirebaseDataManager.swift
//  Core
//
//  Created by Maksim Sashcheka on 19.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

//import FirebaseStorage
import Utils

// TODO: - Remove FirebaseProvider and move all logic with firebase here
public final class FirebaseDataManager: FirebaseDataManagerProtocol {
    public func uploadImage(imageData: Data,
                            success: @escaping Closure.String,
                            failure: @escaping Closure.GeneralError) {
//        let storageRef = Storage.storage().reference()
//
//        let path = "images/\(UUID().uuidString).jpg"
//        let fileRef = storageRef.child(path)
//
//        let uploadTask = fileRef.putData(imageData, metadata: nil) { metaData, error in
//            if error.isNil && !metaData.isNil {
//                fileRef.downloadURL(completion: { url, error in
//                    print(url)
//                })
//
//            }
//        }
    }
    
    public init() { }
}

//
//  FirebaseDataManagerProtocol.swift
//  Core
//
//  Created by Maksim Sashcheka on 19.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

public protocol FirebaseDataManagerProtocol {
    func uploadImage(imageData: Data,
                     success: @escaping Closure.String,
                     failure: @escaping Closure.GeneralError)
}

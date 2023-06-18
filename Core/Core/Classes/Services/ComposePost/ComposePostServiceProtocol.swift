//
//  ComposePostServiceProtocol.swift
//  Core
//
//  Created by Maksim Sashcheka on 23.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils
import UIKit.UIImage

public protocol ComposePostServiceProtocol: AnyObject {
    var title: String? { get set }
    var content: String? { get set }
    var image: UIImage? { get set }
    
    func submitPost(imageURL: String,
                    success: @escaping Closure.Void,
                    failure: @escaping Closure.ServiceError)
}

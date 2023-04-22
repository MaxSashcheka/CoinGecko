//
//  ComposeUserServiceProtocol.swift
//  Core
//
//  Created by Maksim Sashcheka on 17.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils
import UIKit.UIImage

public protocol ComposeUserServiceProtocol: AnyObject {
    var username: String? { get set }
    var login: String? { get set }
    var password: String? { get set }
    var email: String? { get set }
    var role: String? { get set }
    var personalWebLink: String? { get set }
    var image: UIImage? { get set }
    
    func submitUser(imageURL: String,
                    success: @escaping Closure.Void,
                    failure: @escaping Closure.GeneralError)
}

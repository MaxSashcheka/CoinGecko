//
//  ComposeUserCacheDataManager.swift
//  Core
//
//  Created by Maksim Sashcheka on 17.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Foundation
import UIKit.UIImage

public final class ComposeUserCacheDataManager: ComposeUserCacheDataManagerProtocol {
    public var username: String?
    public var login: String?
    public var password: String?
    public var email: String?
    public var personalWebLink: String?
    public var image: UIImage?
    
    public init() { }
}

//
//  AppPropertyCodable.swift
//  Core
//
//  Created by Maksim Sashcheka on 26.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Foundation

public protocol AppPropertyEncodable {
    init?(appPropertyValue: NSCoding)
}

public protocol AppPropertyDecodable {
    var appPropertyValue: NSCoding { get }
}

public protocol AppPropertyCodable: AppPropertyEncodable, AppPropertyDecodable { }

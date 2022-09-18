//
//  ParameterEncoding.swift
//  Core
//
//  Created by Maksim Sashcheka on 17.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Foundation

public typealias Parameters = [String : Any]

public protocol ParameterEncoderProtocol {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

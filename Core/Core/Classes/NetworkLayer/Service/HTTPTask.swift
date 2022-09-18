//
//  HTTPTask.swift
//  Core
//
//  Created by Maksim Sashcheka on 17.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String : String]

public enum HTTPTask {
    case request
    
    case requestParameters(bodyParameters: Parameters? = nil,
                           urlParameters: Parameters? = nil,
                           pathParameters: [String : String]? = nil)
    
    case requestParametersAndHeaders(bodyParameters: Parameters? = nil,
                                     urlParameters: Parameters? = nil,
                                     additionHeaders: HTTPHeaders? = nil)
}

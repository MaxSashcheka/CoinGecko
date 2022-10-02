//
//  APIError.swift
//  Utils
//
//  Created by Maksim Sashcheka on 2.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Foundation

public enum APIError: String, Error {
    case corruptedErrorResponse
    case corruptedResponse
    case mappingError
}

public extension Closure {
    typealias APIError = (Utils.APIError) -> Swift.Void
}

//
//  NetworkError.swift
//  Core
//
//  Created by Maksim Sashcheka on 17.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Foundation

public enum NetworkError: String, Error {
    case parametersNil = "Parameters were nil"
    case encodingFailed = "Parameter encoding failed"
    case missingURL = "URL is nil"
    case removingPercentEncoding = "cant remove percent encoding"
}

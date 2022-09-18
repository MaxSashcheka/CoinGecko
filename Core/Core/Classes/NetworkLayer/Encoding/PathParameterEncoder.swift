//
//  PathParameterEncoder.swift
//  Core
//
//  Created by Maksim Sashcheka on 18.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Foundation

public struct PathParameterEncoder {
    public static func encode(urlRequest: inout URLRequest, with parameters: [String : String]) throws {
        guard let url = urlRequest.url else { throw NetworkError.missingURL }
        // removingPercentEncoding is required because erros during request initialization
        // Cant create URLRequest with url contains /{id} path
        guard let urlString = url.absoluteString.removingPercentEncoding else { throw NetworkError.removingPercentEncoding }
        
        let encodedURLString = parameters.reduce(urlString, { path, queryElement in
            path.replacingOccurrences(
                of: "{" + queryElement.key + "}",
                with: queryElement.value,
                options: .literal
            )
        })
        
        urlRequest.url = URL(string: encodedURLString)
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type").isNil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
    }
}

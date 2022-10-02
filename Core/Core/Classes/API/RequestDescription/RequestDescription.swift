//
//  RequestDescription.swift
//  Core
//
//  Created by Maksim Sashcheka on 1.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Alamofire

public struct RequestDescription {
    let path: String
    let method: HTTPMethod
    let encoding: ParameterEncoding
    let parameters: [String: Any]?
    let headers: HTTPHeaders?
    let isAuthRequired: Bool
    
    public init(path: String,
                method: HTTPMethod,
                encoding: ParameterEncoding,
                parameters: [String: Any]?,
                headers: HTTPHeaders?,
                isAuthRequired: Bool) {
        self.path = path
        self.method = method
        self.encoding = encoding
        self.parameters = parameters
        self.headers = headers
        self.isAuthRequired = isAuthRequired
    }
    
    public init(path: String,
                method: HTTPMethod,
                encoding: ParameterEncoding,
                parameters: [String: Any]?,
                headers: [String: String],
                isAuthRequired: Bool) {
        self.init(
            path: path,
            method: method,
            encoding: encoding,
            parameters: parameters,
            headers: .init(headers),
            isAuthRequired: isAuthRequired
        )
    }
    
    public init(path: String,
                method: HTTPMethod,
                isAuthRequired: Bool) {
        self.init(
            path: path,
            method: method,
            encoding: URLEncoding.default,
            parameters: nil,
            headers: nil,
            isAuthRequired: isAuthRequired
        )
    }
}

// MARK: - Modify

public extension RequestDescription {
    func replacingParameters(_ paramsDict: [String: Any]) -> RequestDescription {
        RequestDescription(
            path: path,
            method: method,
            encoding: encoding,
            parameters: paramsDict,
            headers: headers,
            isAuthRequired: isAuthRequired
        )
    }
    
    func replacingParameters(_ parametersProvider: ParametersProvider) -> RequestDescription {
        replacingParameters(parametersProvider.parameters)
    }
    
    func replacingInlineArguments(_ dict: [String: String]) -> RequestDescription {
        RequestDescription(
            path: dict.reduce(path, { path, queryElement in
                        path.replacingOccurrences(
                            of: "{" + queryElement.key + "}",
                            with: queryElement.value,
                            options: .literal
                        )
            }),
            method: method,
            encoding: encoding,
            parameters: parameters,
            headers: headers,
            isAuthRequired: isAuthRequired
        )
    }
    
    func replacingInlineArguments(_ parametersProvider: ParametersProvider) -> RequestDescription {
        replacingInlineArguments(parametersProvider.parameters.compactMapValues { $0 })
    }
    
    func replacingQueryParameters(_ dict: [String: String]) -> RequestDescription {
        RequestDescription(
            path: path + "?" + dict.sorted { $0.key < $1.key }
                               .map { [$0.key, $0.value].joined(separator: "=") }
                               .compactMap { $0.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) }
                               .joined(separator: "&"),
            method: method,
            encoding: encoding,
            parameters: parameters,
            headers: headers,
            isAuthRequired: isAuthRequired
        )
    }
    
    func replacingQueryParameters(_ dict: [String: Any]) -> RequestDescription {
        replacingQueryParameters(dict.compactMapValues { "\($0)" })
    }
    
    func replacingQueryParameters(_ parametersProvider: ParametersProvider) -> RequestDescription {
        replacingQueryParameters(parametersProvider.parameters.compactMapValues { $0 })
    }
    
    func replacingEncoding(_ encoding: ParameterEncoding) -> RequestDescription {
        RequestDescription(
            path: self.path,
            method: self.method,
            encoding: encoding,
            parameters: self.parameters,
            headers: self.headers,
            isAuthRequired: self.isAuthRequired
        )
    }
}

//
//  NetworkRouterProtocol.swift
//  Core
//
//  Created by Maksim Sashcheka on 17.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Utils

protocol NetworkRouterProtocol: AnyObject {
    associatedtype EndPoint: EndPointType
    
    func request<ResponseType: Decodable>(_ route: EndPoint,
                                          success: @escaping (ResponseType) -> Void,
                                          failure: @escaping NetworkRouterErrorClosure)
    func cancel()
}

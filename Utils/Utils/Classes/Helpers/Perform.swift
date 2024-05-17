//
//  Perform.swift
//  Utils
//
//  Created by Maksim Sashcheka on 28.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Foundation

public class Perform {
    private init() {}
    
    public static func batch<Input, R, ErrorType: Error>(
        _ input: [Input],
        action: (Input, @escaping (R) -> Void, @escaping (ErrorType) -> Void) -> Void,
        success: @escaping ([R]) -> Void,
        failure: @escaping (ErrorType) -> Void
    ) {
        guard !input.isEmpty else {
            success([])
            return
        }
        
        var results: [R] = []
        var failureError: ErrorType?
        
        for item in input {
            action(item, { result in
                guard failureError == nil else { return }
                results.append(result)
                if results.count == input.count {
                    success(results)
                }
            }, { error in
                guard failureError.isNil else { return }
                failureError = error
                failure(error)
            })
        }
    }
}

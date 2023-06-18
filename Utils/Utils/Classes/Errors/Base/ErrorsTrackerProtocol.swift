//
//  ErrorsTrackerProtocol.swift
//  Utils
//
//  Created by Maksim Sashcheka on 17.06.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

public protocol ErrorsTrackerProtocol: AnyObject {
    func track(error: Error)
}

public extension ErrorsTrackerProtocol {
    var trackClosure: Closure.Error {
        { [weak self] in self?.track(error: $0) }
    }
}

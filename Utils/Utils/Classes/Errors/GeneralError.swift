//
//  GeneralError.swift
//  Utils
//
//  Created by Maksim Sashcheka on 2.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Foundation

public enum GeneralError: String, Error {
    case corrutpedDataResponse = "Corrupted data response"
    case corruptedResponse = "Corrupted response"
    case coreDataError = "Error during fetching data from database"
    case unacceptableStatusCode = "Some server error"
}

public extension Closure {
    typealias GeneralError = (Utils.GeneralError) -> Swift.Void
}

//
//  AppError.swift
//  Utils
//
//  Created by Maksim Sashcheka on 17.06.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

public enum AppErrorCode: Int, BaseErrorCode {
    case unexpected
    case notImplemented
    case argumentMissing
    case argumentInvalid
    case notAvailable
}

public final class AppError: BaseError<AppErrorCode> {
    
}

public extension Closure {
    typealias AppError = (Utils.AppError) -> Swift.Void
}

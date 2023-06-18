//
//  FirebaseError.swift
//  Core
//
//  Created by Maksim Sashcheka on 17.06.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

public enum FirebaseErrorCode: Int, BaseErrorCode {
    case undefined
    
    case uploadImage

}

public final class FirebaseError: BaseError<FirebaseErrorCode> {
    public override var domainCode: String { "FIREBASE" }
}

public extension Closure {
    typealias FirebaseError = (Core.FirebaseError) -> Swift.Void
}

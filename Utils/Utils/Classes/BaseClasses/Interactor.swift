//
//  Interactor.swift
//  Utils
//
//  Created by Maksim Sashcheka on 14.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Foundation

/**
 The base class for the business logic. Split the application business logic to separate
 **use cases** and put each use case to a single interactor. Follow the *'Single Responsibility'* design principle
 during the development of the business logic (interactors) layer.
 Custom interactors may contain strong references to:
 - Data managers (or other instances) that can load and store business models
 - Data sessions - objects that hold mutable application state
 - Other interactors (if it is really nesessary)
 */
open class Interactor {
    public init() {
        // Do nothing. Empty constructor required
    }
}

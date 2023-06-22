//
//  Aliases.swift
//  Core
//
//  Created by Maksim Sashcheka on 21.06.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Foundation

public typealias Completion<Success, Error: Swift.Error> = (Result<Success, Error>) -> Void

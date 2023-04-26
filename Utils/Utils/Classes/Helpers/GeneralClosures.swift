//
//  GeneralClosures.swift
//  Utils
//
//  Created by Maksim Sashcheka on 17.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Foundation
import UIKit

public enum Closure {
    public typealias Void = () -> Swift.Void
    public typealias Bool = (Swift.Bool) -> Swift.Void
    public typealias String = (Swift.String) -> Swift.Void
    public typealias OptionalString = (Swift.String?) -> Swift.Void
    public typealias Int = (Swift.Int) -> Swift.Void
    public typealias Double = (Swift.Double) -> Swift.Void
    public typealias Error = (Swift.Error) -> Swift.Void
    public typealias UUID = (Foundation.UUID) -> Swift.Void
    public typealias URL = (Foundation.URL) -> Swift.Void
    public typealias UIImage = (UIKit.UIImage) -> Swift.Void
    public typealias UIColor = (UIKit.UIColor) -> Swift.Void
    public typealias Data = (Foundation.Data) -> Swift.Void
    public typealias OptionalData = (Foundation.Data?) -> Swift.Void
}

//
//  Date+Extensions.swift
//  Utils
//
//  Created by Maksim Sashcheka on 16.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Foundation

extension Date {
    public var calendarRangeWithYearString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd yyyy hh:mm"
        return dateFormatter.string(from: self)
    }
}

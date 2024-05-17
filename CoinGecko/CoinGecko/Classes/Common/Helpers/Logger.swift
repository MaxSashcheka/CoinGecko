//
//  Logger.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 17.06.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Foundation

public class Logger {
    public static func log(_ message: Any,
                           line: Int = #line,
                           funcName: String = #function) {
        print("\(funcName) -> '\(message)'")
    }
}

//
//  EventsTracker+ErrosTrackerProtocol.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 17.06.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

extension EventsTracker: ErrorsTrackerProtocol {
    public func track(error: Error) {
        guard let error = error as? AnyError else {
            Logger.log(error)
            return
        }
        Logger.log(error.recursiveCodeShort + "\n" + error.fullRecursiveInfo)
    }
}

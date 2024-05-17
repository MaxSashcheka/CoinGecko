//
//  UserTableCellViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 28.05.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils
import Combine
import Core

extension UserTableCell {
    final class ViewModel {
        let imageURL = CurrentValueSubject<URL?, Never>(nil)
        let name = CurrentValueSubject<String, Never>(.empty)
        var selectClosure: Closure.Void
        
        init(imageURL: URL?, name: String, selectClosure: @escaping Closure.Void) {
            self.imageURL.send(imageURL)
            self.name.send(name)
            self.selectClosure = selectClosure
        }
    }
}

//
//  TitledTextFieldViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 16.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import Utils

extension TitledTextField {
    final class ViewModel {
        let title = CurrentValueSubject<String, Never>(.empty)
        let errorHintText = CurrentValueSubject<String, Never>(.empty)
        let isErrorVisible = CurrentValueSubject<Bool, Never>(false)
        let isSecureTextEntry = CurrentValueSubject<Bool, Never>(false)
        let text = CurrentValueSubject<String, Never>(.empty)
        
        var saveTextClosure: Closure.String?
        
        init(title: String, errorHintText: String, isSecureTextEntry: Bool = false) {
            self.title.send(title)
            self.errorHintText.send(errorHintText)
            self.isSecureTextEntry.send(isSecureTextEntry)
        }
        
        func didEnterText(_ value: String) {
            text.send(value)
            saveTextClosure?(value)
        }
    }
}

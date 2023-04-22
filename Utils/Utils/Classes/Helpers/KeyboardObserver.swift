//
//  KeyboardObserver.swift
//  Utils
//
//  Created by Maksim Sashcheka on 17.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import UIKit

public class KeyboardHeightObserver {
    public let heightSubject = CurrentValueSubject<CGFloat, Never>(.zero)
    public let keyboardWillShowSubject = PassthroughSubject<Void, Never>()
    public let keyboardWillHideubject = PassthroughSubject<Void, Never>()

    private var cancellables: [AnyCancellable] = []

    public init() {
        NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillHideNotification)
            .mapToVoid()
            .bind(to: keyboardWillHideubject)
            .store(in: &cancellables)
        
        NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillShowNotification)
            .mapToVoid()
            .bind(to: keyboardWillShowSubject)
            .store(in: &cancellables)
    }
}

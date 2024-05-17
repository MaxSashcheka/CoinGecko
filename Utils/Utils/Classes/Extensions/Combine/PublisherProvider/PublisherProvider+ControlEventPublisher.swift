//
//  PublisherProvider+ControlEventPublisher.swift
//  Utils
//
//  Created by Maksim Sashcheka on 2.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import UIKit

public extension PublisherProvider where Self: UIControl {
    func publisher(for events: UIControl.Event) -> AnyPublisher<Self, Never> {
        ControlEventPublisher(control: self, events: events).eraseToAnyPublisher()
    }
    
    func voidPublisher(for events: UIControl.Event) -> AnyPublisher<Void, Never> {
        ControlEventPublisher(control: self, events: events).mapToVoid().eraseToAnyPublisher()
    }
    
    var tapPublisher: AnyPublisher<Void, Never> {
        voidPublisher(for: .touchUpInside).eraseToAnyPublisher()
    }
}

public extension PublisherProvider where Self: UITextField {
    var optionalTextPublisher: AnyPublisher<String?, Never> {
        publisher(for: .editingChanged).map { $0.text }.eraseToAnyPublisher()
    }
    
    var textPublisher: AnyPublisher<String, Never> {
        optionalTextPublisher.replaceNil(with: .empty).eraseToAnyPublisher()
    }
}

public extension PublisherProvider where Self: UITextView {
    var optionalTextPublisher: AnyPublisher<String?, Never> {
        NotificationCenter.default.publisher(for: UITextView.textDidChangeNotification)
            .map { ($0.object as? UITextView)?.text }
            .eraseToAnyPublisher()
    }

    var textPublisher: AnyPublisher<String, Never> {
        optionalTextPublisher.replaceNil(with: .empty).eraseToAnyPublisher()
    }
}

//
//  TapPublisher.swift
//  Utils
//
//  Created by Maksim Sashcheka on 2.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import UIKit

public extension UIView {
    class TapPublisher<View, Recognizer: UIGestureRecognizer>: Publisher where View: UIView {
        public typealias Output = Recognizer
        public typealias Failure = Never
        
        private let view: View
        private let recognizer: Recognizer
        
        public init(view: View, recognizer: Recognizer, cancelsTouchesInView: Bool = false) {
            self.view = view
            self.recognizer = recognizer
            self.recognizer.cancelsTouchesInView = cancelsTouchesInView
        }
        
        public func receive<S>(subscriber: S) where S: Subscriber, Failure == S.Failure, Output == S.Input {
            let subscription = TapSubscription(subscriber: subscriber, recognizer: recognizer, view: view)
            subscriber.receive(subscription: subscription)
        }
    }
}


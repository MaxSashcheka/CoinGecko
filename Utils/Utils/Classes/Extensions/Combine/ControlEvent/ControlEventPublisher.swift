//
//  ControlEventPublisher.swift
//  Utils
//
//  Created by Maksim Sashcheka on 2.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import UIKit

public extension UIControl {
    struct ControlEventPublisher<Control>: Combine.Publisher where Control: UIControl {
        public typealias Output = Control
        public typealias Failure = Never
        
        private let control: Control
        private let events: UIControl.Event
        
        public init(control: Control, events: UIControl.Event) {
            self.control = control
            self.events = events
        }
        
        public func receive<S>(subscriber: S) where S: Subscriber, Failure == S.Failure, Output == S.Input {
            let subscription = ControlEventSubscription(subscriber: subscriber, control: control, event: events)
            subscriber.receive(subscription: subscription)
        }
    }
}

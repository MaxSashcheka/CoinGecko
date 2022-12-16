//
//  ControlEventSubscription.swift
//  Utils
//
//  Created by Maksim Sashcheka on 2.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import UIKit

public extension UIControl {
    final class ControlEventSubscription<SubscriberType, Control>: Combine.Subscription where SubscriberType: Subscriber, Control: UIControl, SubscriberType.Input == Control {
        private var subscriber: SubscriberType?
        private var control: Control?
        
        public init(subscriber: SubscriberType, control: Control, event: UIControl.Event) {
            self.subscriber = subscriber
            self.control = control
            
            control.addTarget(self, action: #selector(handleEvent), for: event)
        }
        
        @objc
        private func handleEvent() {
            guard let control = control else { return }
            _ = subscriber?.receive(control)
        }
        
        public func request(_ demand: Subscribers.Demand) {
            // Empty
        }
        
        public func cancel() {
            DispatchQueue.asyncDispatchToMainIfNeeded {
                self.control?.removeTarget(nil, action: nil, for: .allEvents)
                
                self.subscriber = nil
                self.control = nil
            }
        }
    }
}


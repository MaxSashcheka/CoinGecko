//
//  TapSubscription.swift
//  Utils
//
//  Created by Maksim Sashcheka on 2.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import UIKit

public extension UIView {
    class TapSubscription<SubscriberType, Recognizer, View>: Subscription where SubscriberType: Subscriber,
                                                                                     View: UIView,
                                                                                     Recognizer: UIGestureRecognizer,
                                                                                     SubscriberType.Input == Recognizer {
        private var subscriber: SubscriberType?
        private var recognizer: Recognizer?
        
        public init(subscriber: SubscriberType, recognizer: Recognizer, view: View) {
            self.subscriber = subscriber
            self.recognizer = recognizer
            
            addRecognizer(recognizer, to: view)
        }
        
        private func addRecognizer(_ recognizer: Recognizer, to view: View) {
            view.addGestureRecognizer(recognizer)
            recognizer.addTarget(self, action: #selector(handleRecognizer))
        }
        
        @objc private func handleRecognizer() {
            guard let recognizer = recognizer else { return }
            _ = subscriber?.receive(recognizer)
        }
        
        public func request(_ demand: Subscribers.Demand) {
            // Empty
        }
        
        public func cancel() {
            DispatchQueue.syncDispatchToMainIfNeeded {
                recognizer?.removeTarget(nil, action: nil)
                recognizer.map { $0.view?.removeGestureRecognizer($0) }
                
                subscriber = nil
                recognizer = nil
            }
        }
    }
}

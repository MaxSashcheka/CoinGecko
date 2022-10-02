//
//  PublisherProvider+TouchPublisher.swift
//  Utils
//
//  Created by Maksim Sashcheka on 2.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import UIKit

public extension PublisherProvider where Self: UIView {
    func gesturePublisher<Recognizer>(with recognizer: Recognizer) -> AnyPublisher<Recognizer, Never> where Recognizer: UIGestureRecognizer {
        TapPublisher(view: self, recognizer: recognizer).eraseToAnyPublisher()
    }
    
    func tapPublisher(numberOfTaps: Int? = nil, numberOfTouches: Int? = nil) -> AnyPublisher<UITapGestureRecognizer, Never> {
        TapPublisher(
            view: self,
            recognizer: .tap(
                numberOfTaps: numberOfTaps,
                numberOfTouches: numberOfTouches
            )
        ).eraseToAnyPublisher()
    }
    
    func longPressPublisher(minPressDuration: TimeInterval? = nil, numberOfTouches: Int? = nil) -> AnyPublisher<UILongPressGestureRecognizer, Never> {
        TapPublisher(
            view: self,
            recognizer: .longPress(
                minPressDuration: minPressDuration,
                numberOfTouches: numberOfTouches
            )
        ).eraseToAnyPublisher()
    }
    
    func swipePublisher(direction: UISwipeGestureRecognizer.Direction, numberOfTouches: Int? = nil) -> AnyPublisher<UISwipeGestureRecognizer, Never> {
        TapPublisher(
            view: self,
            recognizer: .swipe(
                direction: direction,
                numberOfTouches: numberOfTouches
            )
        ).eraseToAnyPublisher()
    }
    
    func panPublisher(minNumberOfTouches: Int? = nil, maxNumberOfTouches: Int? = nil) -> AnyPublisher<UIPanGestureRecognizer, Never> {
        TapPublisher(
            view: self,
            recognizer: .pan(
                minNumberOfTouches: minNumberOfTouches,
                maxNumberOfTouches: maxNumberOfTouches
            )
        ).eraseToAnyPublisher()
    }
    
    func pinchPublisher(scale: CGFloat? = nil) -> AnyPublisher<UIPinchGestureRecognizer, Never> {
        TapPublisher(
            view: self,
            recognizer: .pinch(scale: scale)
        ).eraseToAnyPublisher()
    }
    
    func edgePanPublisher(edges: UIRectEdge) -> AnyPublisher<UIScreenEdgePanGestureRecognizer, Never> {
        TapPublisher(
            view: self,
            recognizer: .edgePan(edges: edges)
        ).eraseToAnyPublisher()
    }
}


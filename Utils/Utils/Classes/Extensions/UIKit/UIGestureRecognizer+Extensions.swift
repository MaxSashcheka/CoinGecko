//
//  UIGestureRecognizer+Extensions.swift
//  Utils
//
//  Created by Maksim Sashcheka on 2.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import UIKit

public extension UIGestureRecognizer {
    static func tap(numberOfTaps: Int? = nil,
                    numberOfTouches: Int? = nil) -> UITapGestureRecognizer {
        let recognizer = UITapGestureRecognizer()
        
        if let numberOfTaps = numberOfTaps {
            recognizer.numberOfTapsRequired = numberOfTaps
        }
        if let numberOfTouches = numberOfTouches {
            recognizer.numberOfTouchesRequired = numberOfTouches
        }
        
        return recognizer
    }
    
    static func longPress(minPressDuration: TimeInterval? = nil,
                          numberOfTouches: Int? = nil) -> UILongPressGestureRecognizer {
        let recognizer = UILongPressGestureRecognizer()
        
        if let minPressDuration = minPressDuration {
            recognizer.minimumPressDuration = minPressDuration
        }
        if let numberOfTouches = numberOfTouches {
            recognizer.numberOfTouchesRequired = numberOfTouches
        }
        
        return recognizer
    }
    
    static func swipe(direction: UISwipeGestureRecognizer.Direction,
                      numberOfTouches: Int? = nil) -> UISwipeGestureRecognizer {
        let recognizer = UISwipeGestureRecognizer()
        
        recognizer.direction = direction
        if let numberOfTouches = numberOfTouches {
            recognizer.numberOfTouchesRequired = numberOfTouches
        }
        
        return recognizer
    }
    
    static func pan(minNumberOfTouches: Int? = nil,
                    maxNumberOfTouches: Int? = nil) -> UIPanGestureRecognizer {
        let recognizer = UIPanGestureRecognizer()
        
        if let minNumberOfTouches = minNumberOfTouches {
            recognizer.minimumNumberOfTouches = minNumberOfTouches
        }
        if let maxNumberOfTouches = maxNumberOfTouches {
            recognizer.maximumNumberOfTouches = maxNumberOfTouches
        }
        
        return recognizer
    }
    
    static func pinch(scale: CGFloat? = nil) -> UIPinchGestureRecognizer {
        let recognizer = UIPinchGestureRecognizer()
        
        if let scale = scale {
            recognizer.scale = scale
        }
        
        return recognizer
    }
    
    static func edgePan(edges: UIRectEdge) -> UIScreenEdgePanGestureRecognizer {
        let recognizer = UIScreenEdgePanGestureRecognizer()
        recognizer.edges = edges
        return recognizer
    }
}


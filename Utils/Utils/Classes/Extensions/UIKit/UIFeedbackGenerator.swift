//
//  UIFeedbackGenerator.swift
//  Utils
//
//  Created by Maksim Sashcheka on 4.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import AVFoundation
import UIKit

public extension UIFeedbackGenerator {
    static func generateFeedback(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        AudioServicesPlaySystemSoundWithCompletion(1104, nil)
        UIImpactFeedbackGenerator(style: style).impactOccurred()
    }
}


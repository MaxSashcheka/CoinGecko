//
//  PriceTriangleView.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 29.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import UIKit
import Utils

class PriceTriangleView: View {
    var state: State = .loser {
        didSet {
            fillColor = state == .gainer ? .green : .red
            setNeedsDisplay()
        }
    }
    
    private var fillColor: UIColor = .systemRed
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
    
        context.beginPath()

        switch state {
        case .loser:
            context.move(to: .init(x: rect.minX, y: rect.minY))
            context.addLine(to: .init(x: rect.maxX, y: rect.minY))
            context.addLine(to: .init(x: (rect.maxX / 2.0), y: rect.maxY))
        case .gainer:
            context.move(to: .init(x: rect.minX, y: rect.maxY))
            context.addLine(to: .init(x: rect.maxX, y: rect.maxY))
            context.addLine(to: .init(x: (rect.maxX / 2.0), y: rect.minY))
        }
        context.closePath()
        
        context.setFillColor(fillColor.cgColor)
        context.fillPath()
    }
}

// MARK: - PriceTriangleView+State
extension PriceTriangleView {
    enum State {
        case loser, gainer
    }
}

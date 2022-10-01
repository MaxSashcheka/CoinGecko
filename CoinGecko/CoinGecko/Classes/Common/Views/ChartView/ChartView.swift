//
//  ChartView.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 25.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit
import Utils

final class ChartView: View {
    enum PriceType {
        case max, min
    }
    
    private var disposeBag = DisposeBag()

    var viewModel: ViewModel? {
        didSet {
            disposeBag = DisposeBag()
            guard let viewModel = viewModel else { return }
            
            bindData(with: viewModel)
        }
    }
    
    private func bindData(with viewModel: ViewModel) {
        viewModel.dataRelay
            .asDriver()
            .drive(onNext: { [weak self] _ in
                self?.setNeedsDisplay()
            })
            .disposed(by: disposeBag)
    }
    
    override func initialize() {
        backgroundColor = .white
    }
    
    override func draw(_ rect: CGRect) {
        removeAllSubviews()
        guard let originalChartData = viewModel?.chartData else { return }

        var skipValuesCoefficient = 1
        switch originalChartData.count {
        case 100...200: skipValuesCoefficient = 2
        case 200...1000: skipValuesCoefficient = 3
        case 1000...10000: skipValuesCoefficient = 15
        default: break
        }

        var sortedChartData: [CGFloat] = []
        for index in originalChartData.indices where index % skipValuesCoefficient == 0 && skipValuesCoefficient != .zero {
            sortedChartData.append(originalChartData[index])
        }

        let path = UIBezierPath()

        let (width, height) = (rect.width, rect.height)
        let maxY = sortedChartData.max() ?? .zero
        let minY = sortedChartData.min() ?? .zero
        let yAxis = maxY - minY

        for index in sortedChartData.indices {
            // TODO: - REfactor coordinate calculation for current and previous coordinates
            let currentXCoordinate = width / CGFloat(sortedChartData.count) * CGFloat(index + 1)
            let currentYCoordinate = (1 - CGFloat((sortedChartData[index] - minY) / yAxis)) * height
            if index == .zero {
                path.move(to: .init(x: .zero, y: currentYCoordinate))
            } else {
                let previousIndex = index - 1
                let previousXCoordinate = width / CGFloat(sortedChartData.count) * CGFloat(previousIndex + 1)
                let previousYCoordinate = (1 - CGFloat((sortedChartData[previousIndex] - minY) / yAxis)) * height

                let middleXCoodinate = (currentXCoordinate + previousXCoordinate) / 2
                let middleYCoodinate = (currentYCoordinate + previousYCoordinate) / 2
                path.addQuadCurve(to: .init(x: currentXCoordinate, y: currentYCoordinate),
                                  controlPoint: .init(x: middleXCoodinate, y: middleYCoodinate))
            }

            if sortedChartData[index] == maxY {
                arrangePriceLabelFor(point: .init(x: currentXCoordinate, y: currentYCoordinate),
                                     priceValue: sortedChartData[index],
                                     type: .max)
            } else if sortedChartData[index] == minY {
                arrangePriceLabelFor(point: .init(x: currentXCoordinate, y: currentYCoordinate),
                                     priceValue: sortedChartData[index],
                                     type: .min)
            }
        }

        Constants.Colors.chartColor.setStroke()
        path.lineWidth = 2
        path.stroke()
    }
    
    func arrangePriceLabelFor(point: CGPoint, priceValue: CGFloat, type: PriceType) {
        let labelFont = Constants.Fonts.priceLabel
        let roundedPrice = preciseRound(priceValue, precision: .hundredths).description
        let width: CGFloat = roundedPrice.width(font: labelFont)
        let height: CGFloat = roundedPrice.height(font: labelFont)
        
        let xCoordinate = max(point.x - width / 2, .zero)
        let yCoordinate = point.y + (type == .max ? -Constants.priceLabelInset : 5)

        let label = Label(frame: .init(x: xCoordinate, y: yCoordinate, width: width, height: height))
        label.font = labelFont
        label.text = roundedPrice
        label.textColor = type == .max ? Constants.Colors.maximumPrice : Constants.Colors.minimumPrice

        addSubview(label)
    }
}

private extension ChartView {
    enum Constants {
        static let skipValuesCount = 10
        static let priceLabelInset: CGFloat = 15
        enum Fonts {
            static let priceLabel: UIFont = .systemFont(ofSize: 10, weight: .medium)
        }
        enum Colors {
            static let chartColor: UIColor = .systemBlue
            static let maximumPrice: UIColor = .systemGreen
            static let minimumPrice: UIColor = .systemRed
        }
    }
}





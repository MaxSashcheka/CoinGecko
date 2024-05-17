//
//  ChartView.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 25.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Charts
import Combine
import UIKit
import Utils

final class ChartView: View {
    private typealias Colors = AppStyle.Colors.Chart
    
    private let stackView: UIStackView = .make {
        $0.axis = .vertical
    }
    
    private let rootChartView: LineChartView = .make {
        $0.leftAxis.enabled = false
        $0.rightAxis.enabled = false
        $0.xAxis.enabled = false
    }
    
    private let metadataLabel: Label = .make {
        $0.font = .systemFont(ofSize: 23, weight: .regular)
        $0.textAlignment = .center
        $0.numberOfLines = .zero
    }
    
    // MARK: - Properties

    var viewModel: ViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            cancellables.removeAll()
            
            bindData(with: viewModel)
        }
    }
    
    // MARK: - Methods
    
    private func bindData(with viewModel: ViewModel) {
        viewModel.dataSubject
            .sink { [weak self] in
                let entries = $0.enumerated().map {
                    ChartDataEntry(x: Double($0), y: $1.price)
                }
                let dataSet = LineChartDataSet(entries: entries, label: .empty)
                guard let gradient = CGGradient(
                    colorsSpace: CGColorSpaceCreateDeviceRGB(),
                    colors: [UIColor.green.cgColor, UIColor.green.withAlphaComponent(0.05).cgColor] as CFArray,
                    locations: [1.0, 0]
                ) else { return }
                dataSet.drawFilledEnabled = true
                dataSet.fill = LinearGradientFill(gradient: gradient, angle: 90)
                dataSet.mode = .cubicBezier
                dataSet.drawCirclesEnabled = false
                dataSet.lineWidth = 1
                let chartData = LineChartData(dataSet: dataSet)
                chartData.setDrawValues(false)
                self?.rootChartView.data = chartData
                self?.rootChartView.animate(xAxisDuration: 1.5)
            }
            .store(in: &cancellables)
        
        viewModel.selectedMetadata
            .compactMap { $0 }
            .sink { [weak self] metadata in
                let price = preciseRound(metadata.price, precision: .thousandths)
                self?.metadataLabel.text = "\(metadata.date.calendarRangeWithYearString)\n\(price) $"
            }
            .store(in: &cancellables)
    }
    
    override func initialize() {
        backgroundColor = Colors.background
    
        addSubview(rootChartView)
        rootChartView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
        }
        
        addSubview(metadataLabel)
        metadataLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(rootChartView.snp.bottom)
        }
        
        rootChartView.delegate = self
    }
}

// MARK: - ChartView+ChartViewDelegate
extension ChartView: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        viewModel?.didSelectMetadata(at: Int(entry.x))
    }
    
    func chartViewDidEndPanning(_ chartView: ChartViewBase) {
        viewModel?.didEndPanning()
    }
}

// MARK: - ChartView+Constants
private extension ChartView {
    enum Constants {
        static let skipValuesCount = 10
    }
}

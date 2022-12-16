//
//  AppStyle+Colors.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 6.12.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import UIKit.UIColor

extension AppStyle {
    enum Colors {
        typealias Generated = Assets.Colors
        
        static var separator: UIColor { Generated.lightGray.color }
        static var button: UIColor { Generated.blue.color }
        static var error: UIColor { Generated.red.color }
        static var clear: UIColor { Generated.white.color.withAlphaComponent(.zero) }
        
        private enum Background {
            static var primary: UIColor { Generated.platinum.color }
        }
        
        enum TitledDescription {
            static var title: UIColor { Generated.lightBlack.color }
            static var description: UIColor { Generated.darkGray.color }
        }
        
        enum CoinOverlay {
            static var indicator: UIColor { separator }
            static var description: UIColor { Generated.darkGray.color }
            static var amount: UIColor { Generated.black.color }
            
            static var addButton: UIColor { button.withAlphaComponent(0.7) }
            static var failure: UIColor { error }
        }
        
        enum Trending {
            static var table: UIColor { clear }
            static var background: UIColor { Background.primary }
        }
        
        enum RangePickerButton {
            enum Selected {
                static var background: UIColor { button.withAlphaComponent(0.1) }
                static var title: UIColor { button.withAlphaComponent(0.7) }
                static var border: UIColor { button.withAlphaComponent(0.7) }
            }
            enum Unselected {
                static var background: UIColor { separator.withAlphaComponent(0.15) }
                static var title: UIColor { Generated.darkGray.color }
                static var border: UIColor { separator.withAlphaComponent(0.3) }
            }
        }
        
        enum CoinDetails {
            enum NavigationBar {
                static var background: UIColor { Background.primary }
            }
            
            static var background: UIColor { Background.primary }
            static var currentPrice: UIColor { Generated.black.color }
            static var priceChange: UIColor { Generated.green.color }
            static var addButton: UIColor { button.withAlphaComponent(0.65) }
        }
        
        enum Markets {
            enum PageButton {
                static var title: UIColor { Generated.darkGray.color }
                static var bottomLine: UIColor { button }
                static var selected: UIColor { button }
                static var unselected: UIColor { Generated.darkGray.color }
            }
            
            static var statusPlaceholder: UIColor { Generated.black.color }
            static var statusPercentage: UIColor { Generated.red.color }
            static var statusTimePlaceholder: UIColor { Generated.darkGray.color }
            static var tint: UIColor { Generated.darkGray.color }
            static var separatorLine: UIColor { separator.withAlphaComponent(0.7) }
            static var table: UIColor { clear }
            static var background: UIColor { Background.primary }
            static var searchContainer: UIColor { separator.withAlphaComponent(0.2) }
            static var positiveChange: UIColor { Generated.green.color }
            static var negativeChange: UIColor { Generated.red.color }
        }
        
        enum Search {
            enum TextField {
                static var tint: UIColor { separator.withAlphaComponent(0.7) }
            }
            
            static var background: UIColor { Background.primary }
            static var table: UIColor { clear }
        }
        
        enum Home {
            enum CoinCell {
                static var shadow: UIColor { Generated.black.color.withAlphaComponent(0.25) }
                static var shadowBackground: UIColor { Generated.white.color }
                static var placeholder: UIColor { separator }
                static var deleteButton: UIColor { Generated.red.color }
                static var deleteButtonTitle: UIColor { Generated.white.color }
                static var positiveChange: UIColor { Generated.green.color }
                static var negativeChange: UIColor { Generated.red.color }
                static var background: UIColor { clear }
            }
            
            enum CardView {
                static var background: UIColor { button.withAlphaComponent(0.65) }
                static var text: UIColor { Generated.white.color }
            }
            
            enum NavigationBar {
                static var tint: UIColor { Generated.darkGray.color }
                static var separatorLine: UIColor { separator.withAlphaComponent(0.7) }
                
                static var welcome: UIColor { Generated.darkGray.color }
                static var name: UIColor { Generated.black.color.withAlphaComponent(0.9) }
                static var email: UIColor { Generated.darkGray.color.withAlphaComponent(0.9) }
            }
            
            enum Placeholder {
                static var title: UIColor { Generated.black.color }
                static var subtitle: UIColor { Generated.darkGray.color }
            }
            
            static var background: UIColor { Background.primary }
            static var table: UIColor { clear }
        }
        
        enum Chart {
            static var background: UIColor { clear }
            static var chart: UIColor { button }
            static var maxPrice: UIColor { Generated.green.color }
            static var minPrice: UIColor { Generated.red.color }
        }
    }
}

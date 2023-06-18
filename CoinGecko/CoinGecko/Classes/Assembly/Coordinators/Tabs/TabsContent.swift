//
//  TabsContent.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 18.06.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import UIKit.UIImage
import Utils

extension TabContentCoordinator.Tab {
    typealias Texts = L10n.Tabbar.Title
    
    static var trending: Self {
        Self(
            title: Texts.trending,
            unselectedIcon: UIImage(.chart.lineUptrendXyaxis),
            selectedIcon: UIImage(.chart.lineUptrendXyaxis)
        )
    }
    
    static var markets: Self {
        Self(
            title: Texts.markets,
            unselectedIcon: UIImage(.chart.pie),
            selectedIcon: UIImage(.chart.pie)
        )
    }
    
    static var newsList: Self {
        Self(
            title: Texts.news,
            unselectedIcon: UIImage(.newspaper),
            selectedIcon: UIImage(.newspaper)
        )
    }
    
    static var home: Self {
        Self(
            title: Texts.home,
            unselectedIcon: UIImage(.house),
            selectedIcon: UIImage(.house)
        )
    }
}

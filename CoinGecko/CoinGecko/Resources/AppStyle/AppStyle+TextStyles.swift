//
//  AppStyle+TextStyles.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 6.12.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Utils

extension AppStyle {
    enum TextStyles {
        enum TitledDescription {
            static var title: TextStyle {
                .style(font: .systemFont(ofSize: 20, weight: .medium),
                       textColor: .black.withAlphaComponent(0.85))
            }
            
            static var description: TextStyle {
                .style(font: .systemFont(ofSize: 15, weight: .regular),
                       textColor: .darkGray)
            }
        }
        
        enum CoinOverlay {
            static var description: TextStyle {
                .style(font: .systemFont(ofSize: 17, weight: .regular),
                       textColor: .darkGray)
            }
            
            static var amount: TextStyle {
                .style(font: .systemFont(ofSize: 30, weight: .semibold),
                       textColor: .black)
            }
        }
        
        enum CoinDetails {
            static var currentPrice: TextStyle {
                .style(font: .systemFont(ofSize: 23, weight: .bold),
                       textColor: .black)
            }
            
            static var priceChange: TextStyle {
                .style(font: .systemFont(ofSize: 18, weight: .medium),
                       textColor: .systemGreen)
            }
        }
        
        enum Markets {
            static var statusPlaceholder: TextStyle {
                .style(font: .systemFont(ofSize: 28, weight: .medium),
                       textColor: .black)
            }
            
            static var statusPercentage: TextStyle {
                .style(font: .systemFont(ofSize: 28, weight: .medium),
                       textColor: .systemRed)
            }
            
            static var statusTimePlaceholder: TextStyle {
                .style(font: .systemFont(ofSize: 18, weight: .regular),
                       textColor: .darkGray)
            }
        }
        
        enum NetworthCoin {
            static var deleteButton: TextStyle {
                .style(font: .systemFont(ofSize: 16, weight: .medium),
                       textColor: .white)
            }
        }
        
        enum NetworthCard {
            static var balanceTitle: TextStyle {
                .style(font: .systemFont(ofSize: 24, weight: .regular),
                       textColor: .white)
            }
            
            static var balanceValue: TextStyle {
                .style(font: .systemFont(ofSize: 32, weight: .semibold),
                       textColor: .white)
            }
            
            static var dayProfitTitle: TextStyle {
                .style(font: .systemFont(ofSize: 24, weight: .regular),
                       textColor: .white)
            }
            
            static var dayProfitValue: TextStyle {
                .style(font: .systemFont(ofSize: 32, weight: .semibold),
                       textColor: .white)
            }
        }
        
        enum Home {
            enum NavigationBar {
                static var welcomeTitle: TextStyle {
                    .style(font: .systemFont(ofSize: 30, weight: .semibold),
                           textColor: .darkGray)
                }
                
                static var nameTitle: TextStyle {
                    .style(font: .systemFont(ofSize: 22, weight: .bold),
                           textColor: .black.withAlphaComponent(0.9))
                }
                
                static var emailTitle: TextStyle {
                    .style(font: .systemFont(ofSize: 19, weight: .bold),
                           textColor: .darkGray.withAlphaComponent(0.9))
                }
            }
            
            enum Placeholder {
                static var title: TextStyle {
                    .style(font: .systemFont(ofSize: 24, weight: .semibold),
                           textColor: .black)
                }
                
                static var subtitle: TextStyle {
                    .style(font: .systemFont(ofSize: 21, weight: .semibold),
                           textColor: .darkGray)
                }
            }
        }
        
        
    }
}

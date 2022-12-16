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
                       textColor: Colors.TitledDescription.title)
            }
            
            static var description: TextStyle {
                .style(font: .systemFont(ofSize: 15, weight: .regular),
                       textColor: Colors.TitledDescription.description)
            }
        }
        
        enum CoinOverlay {
            static var description: TextStyle {
                .style(font: .systemFont(ofSize: 17, weight: .regular),
                       textColor: Colors.CoinOverlay.description)
            }
            
            static var amount: TextStyle {
                .style(font: .systemFont(ofSize: 30, weight: .semibold),
                       textColor: Colors.CoinOverlay.amount)
            }
        }
        
        enum CoinDetails {
            enum NavigationBar {
                static var title: TextStyle {
                    .style(font: .systemFont(ofSize: 20, weight: .medium),
                           textColor: .black.withAlphaComponent(0.85))
                }
                
                static var description: TextStyle {
                    .style(font: .systemFont(ofSize: 14, weight: .regular),
                           textColor: .darkGray)
                }
            }
            
            enum RangePickerButton {
                static var title: TextStyle {
                    .style(font: .systemFont(ofSize: 15, weight: .semibold),
                           textColor: Colors.RangePickerButton.Unselected.title)
                }
            }
            
            static var currentPrice: TextStyle {
                .style(font: .systemFont(ofSize: 23, weight: .bold),
                       textColor: Colors.CoinDetails.currentPrice)
            }
            
            static var priceChange: TextStyle {
                .style(font: .systemFont(ofSize: 18, weight: .medium),
                       textColor: Colors.CoinDetails.priceChange)
            }
        }
        
        enum Markets {
            enum PageButton {
                static var title: TextStyle {
                    .style(font: .systemFont(ofSize: 20, weight: .medium),
                           textColor: Colors.Markets.PageButton.title)
                }
            }
            static var statusPlaceholder: TextStyle {
                .style(font: .systemFont(ofSize: 28, weight: .medium),
                       textColor: Colors.Markets.statusPlaceholder)
            }
            
            static var statusPercentage: TextStyle {
                .style(font: .systemFont(ofSize: 28, weight: .medium),
                       textColor: Colors.Markets.statusPercentage)
            }
            
            static var statusTimePlaceholder: TextStyle {
                .style(font: .systemFont(ofSize: 18, weight: .regular),
                       textColor: Colors.Markets.statusTimePlaceholder)
            }
        }
        
        enum NetworthCoin {
            static var deleteButton: TextStyle {
                .style(font: .systemFont(ofSize: 16, weight: .medium),
                       textColor: Colors.Home.CoinCell.deleteButtonTitle)
            }
        }
        
        enum NetworthCard {
            static var balanceTitle: TextStyle {
                .style(font: .systemFont(ofSize: 24, weight: .regular),
                       textColor: Colors.Home.CardView.text)
            }
            
            static var balanceValue: TextStyle {
                .style(font: .systemFont(ofSize: 32, weight: .semibold),
                       textColor: Colors.Home.CardView.text)
            }
            
            static var dayProfitTitle: TextStyle {
                .style(font: .systemFont(ofSize: 24, weight: .regular),
                       textColor: Colors.Home.CardView.text)
            }
            
            static var dayProfitValue: TextStyle {
                .style(font: .systemFont(ofSize: 32, weight: .semibold),
                       textColor: Colors.Home.CardView.text)
            }
        }
        
        enum Home {
            enum NavigationBar {
                static var welcomeTitle: TextStyle {
                    .style(font: .systemFont(ofSize: 30, weight: .semibold),
                           textColor: Colors.Home.NavigationBar.welcome)
                }
                
                static var nameTitle: TextStyle {
                    .style(font: .systemFont(ofSize: 22, weight: .bold),
                           textColor: Colors.Home.NavigationBar.name)
                }
                
                static var emailTitle: TextStyle {
                    .style(font: .systemFont(ofSize: 19, weight: .bold),
                           textColor: Colors.Home.NavigationBar.email)
                }
            }
            
            enum Placeholder {
                static var title: TextStyle {
                    .style(font: .systemFont(ofSize: 24, weight: .semibold),
                           textColor: Colors.Home.Placeholder.title)
                }
                
                static var subtitle: TextStyle {
                    .style(font: .systemFont(ofSize: 21, weight: .semibold),
                           textColor: Colors.Home.Placeholder.subtitle)
                }
            }
        }
    }
}

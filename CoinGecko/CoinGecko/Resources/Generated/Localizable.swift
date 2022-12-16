// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum CoinDetails {
    internal enum AddButton {
      /// Add to portfolio
      internal static let title = L10n.tr("Localizable", "coin_details.add_button.title", fallback: #"Add to portfolio"#)
    }
  }
  internal enum Home {
    internal enum NavigationBar {
      internal enum Title {
        /// sashchekam@gmail.com
        internal static let email = L10n.tr("Localizable", "home.navigation_bar.title.email", fallback: #"sashchekam@gmail.com"#)
        /// Maksim Sashcheka
        internal static let name = L10n.tr("Localizable", "home.navigation_bar.title.name", fallback: #"Maksim Sashcheka"#)
        /// Weclome
        internal static let welcome = L10n.tr("Localizable", "home.navigation_bar.title.welcome", fallback: #"Weclome"#)
      }
    }
    internal enum NetworthCard {
      /// Balance
      internal static let title = L10n.tr("Localizable", "home.networth_card.title", fallback: #"Balance"#)
    }
    internal enum NetworthCell {
      internal enum DeleteButton {
        /// Delete
        internal static let title = L10n.tr("Localizable", "home.networth_cell.delete_button.title", fallback: #"Delete"#)
      }
    }
    internal enum Portfolio {
      internal enum Title {
        /// Portfolio count: %@
        internal static func count(_ p1: Any) -> String {
          return L10n.tr("Localizable", "home.portfolio.title.count", String(describing: p1), fallback: #"Portfolio count: %@"#)
        }
        /// Portfolio networth: %@
        internal static func networth(_ p1: Any) -> String {
          return L10n.tr("Localizable", "home.portfolio.title.networth", String(describing: p1), fallback: #"Portfolio networth: %@"#)
        }
      }
    }
  }
  internal enum Markets {
    internal enum StatusTitle {
      /// Market is down
      internal static let down = L10n.tr("Localizable", "markets.status_title.down", fallback: #"Market is down"#)
      /// Market is up
      internal static let up = L10n.tr("Localizable", "markets.status_title.up", fallback: #"Market is up"#)
    }
    internal enum TimePlaceholder {
      /// In the past 24 hours
      internal static let title = L10n.tr("Localizable", "markets.time_placeholder.title", fallback: #"In the past 24 hours"#)
    }
  }
  internal enum Overlay {
    internal enum Coin {
      /// Enter the amount of the coin
      internal static let title = L10n.tr("Localizable", "overlay.coin.title", fallback: #"Enter the amount of the coin"#)
      internal enum Button {
        /// Add
        internal static let title = L10n.tr("Localizable", "overlay.coin.button.title", fallback: #"Add"#)
      }
    }
  }
  internal enum RangeButton {
    internal enum Title {
      /// All
      internal static let all = L10n.tr("Localizable", "range_button.title.all", fallback: #"All"#)
      /// 24 H
      internal static let day = L10n.tr("Localizable", "range_button.title.day", fallback: #"24 H"#)
      /// 6 M
      internal static let halfYear = L10n.tr("Localizable", "range_button.title.half_year", fallback: #"6 M"#)
      /// 1 H
      internal static let hour = L10n.tr("Localizable", "range_button.title.hour", fallback: #"1 H"#)
      /// 1 M
      internal static let month = L10n.tr("Localizable", "range_button.title.month", fallback: #"1 M"#)
      /// 1 W
      internal static let week = L10n.tr("Localizable", "range_button.title.week", fallback: #"1 W"#)
      /// 1 Y
      internal static let year = L10n.tr("Localizable", "range_button.title.year", fallback: #"1 Y"#)
    }
  }
  internal enum Search {
    /// Search
    internal static let title = L10n.tr("Localizable", "search.title", fallback: #"Search"#)
    internal enum Table {
      internal enum Title {
        /// Crypto coins
        internal static let cryptoCoin = L10n.tr("Localizable", "search.table.title.crypto_coin", fallback: #"Crypto coins"#)
        /// NFTS
        internal static let nft = L10n.tr("Localizable", "search.table.title.nft", fallback: #"NFTS"#)
      }
    }
    internal enum TextField {
      internal enum Placeholder {
        /// Search Cryptocurrency
        internal static let title = L10n.tr("Localizable", "search.text_field.placeholder.title", fallback: #"Search Cryptocurrency"#)
      }
    }
  }
  internal enum Tabbar {
    internal enum Title {
      /// Home
      internal static let home = L10n.tr("Localizable", "tabbar.title.home", fallback: #"Home"#)
      /// Markets
      internal static let markets = L10n.tr("Localizable", "tabbar.title.markets", fallback: #"Markets"#)
      /// Trending
      internal static let trending = L10n.tr("Localizable", "tabbar.title.trending", fallback: #"Trending"#)
    }
  }
  internal enum Trending {
    /// Trending Coins
    internal static let title = L10n.tr("Localizable", "trending.title", fallback: #"Trending Coins"#)
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type

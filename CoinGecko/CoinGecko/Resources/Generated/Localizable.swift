// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum AccountWallets {
    /// Amount: 
    internal static let amount = L10n.tr("Localizable", "account_wallets.amount", fallback: #"Amount: "#)
    ///  coins
    internal static let coins = L10n.tr("Localizable", "account_wallets.coins", fallback: #" coins"#)
    /// Account Wallets
    internal static let title = L10n.tr("Localizable", "account_wallets.title", fallback: #"Account Wallets"#)
    internal enum Placeholder {
      /// Add wallet
      internal static let button = L10n.tr("Localizable", "account_wallets.placeholder.button", fallback: #"Add wallet"#)
      /// No wallets yet.
      internal static let title = L10n.tr("Localizable", "account_wallets.placeholder.title", fallback: #"No wallets yet."#)
    }
  }
  internal enum AddCoin {
    /// Choose wallet
    internal static let title = L10n.tr("Localizable", "add_coin.title", fallback: #"Choose wallet"#)
    internal enum Amount {
      /// Amount should not be empty and have correct format
      internal static let hint = L10n.tr("Localizable", "add_coin.amount.hint", fallback: #"Amount should not be empty and have correct format"#)
      /// Enter amount
      internal static let title = L10n.tr("Localizable", "add_coin.amount.title", fallback: #"Enter amount"#)
    }
    internal enum Button {
      /// Done
      internal static let done = L10n.tr("Localizable", "add_coin.button.done", fallback: #"Done"#)
    }
  }
  internal enum CoinDetails {
    internal enum AddButton {
      /// Add to wallet
      internal static let title = L10n.tr("Localizable", "coin_details.add_button.title", fallback: #"Add to wallet"#)
    }
  }
  internal enum ComposeWallet {
    /// Wallet Preview
    internal static let previewTitle = L10n.tr("Localizable", "compose_wallet.preview_title", fallback: #"Wallet Preview"#)
    /// Create new Wallet
    internal static let title = L10n.tr("Localizable", "compose_wallet.title", fallback: #"Create new Wallet"#)
    internal enum Button {
      /// Finish
      internal static let finish = L10n.tr("Localizable", "compose_wallet.button.finish", fallback: #"Finish"#)
      /// Pick background color
      internal static let pickColor = L10n.tr("Localizable", "compose_wallet.button.pick_color", fallback: #"Pick background color"#)
    }
    internal enum Name {
      /// Wallet title should not be empty
      internal static let hint = L10n.tr("Localizable", "compose_wallet.name.hint", fallback: #"Wallet title should not be empty"#)
      /// Write wallet title
      internal static let title = L10n.tr("Localizable", "compose_wallet.name.title", fallback: #"Write wallet title"#)
    }
  }
  internal enum CreatePhoto {
    internal enum Button {
      /// Finish
      internal static let finish = L10n.tr("Localizable", "create_photo.button.finish", fallback: #"Finish"#)
      /// Choose photo
      internal static let pickPhoto = L10n.tr("Localizable", "create_photo.button.pick_photo", fallback: #"Choose photo"#)
    }
    internal enum Title {
      /// Create Post Photo
      internal static let createPost = L10n.tr("Localizable", "create_photo.title.create_post", fallback: #"Create Post Photo"#)
      /// Create User Photo
      internal static let createUser = L10n.tr("Localizable", "create_photo.title.create_user", fallback: #"Create User Photo"#)
    }
  }
  internal enum CreatePost {
    /// Create new Post
    internal static let continueButton = L10n.tr("Localizable", "create_post.continue_button", fallback: #"Create new Post"#)
    /// Create new Post
    internal static let title = L10n.tr("Localizable", "create_post.title", fallback: #"Create new Post"#)
    internal enum Content {
      /// Content should not be empty
      internal static let hint = L10n.tr("Localizable", "create_post.content.hint", fallback: #"Content should not be empty"#)
      /// Write post content
      internal static let title = L10n.tr("Localizable", "create_post.content.title", fallback: #"Write post content"#)
    }
    internal enum TitleTextField {
      /// Post title should not be empty
      internal static let hint = L10n.tr("Localizable", "create_post.title_text_field.hint", fallback: #"Post title should not be empty"#)
      /// Write post title
      internal static let title = L10n.tr("Localizable", "create_post.title_text_field.title", fallback: #"Write post title"#)
    }
  }
  internal enum CreateUser {
    /// Continue
    internal static let continueButton = L10n.tr("Localizable", "create_user.continue_button", fallback: #"Continue"#)
    /// Create User
    internal static let title = L10n.tr("Localizable", "create_user.title", fallback: #"Create User"#)
    internal enum Email {
      /// Email should not be empty
      internal static let hint = L10n.tr("Localizable", "create_user.email.hint", fallback: #"Email should not be empty"#)
      /// Write email
      internal static let title = L10n.tr("Localizable", "create_user.email.title", fallback: #"Write email"#)
    }
    internal enum Login {
      /// Login should not be empty
      internal static let hint = L10n.tr("Localizable", "create_user.login.hint", fallback: #"Login should not be empty"#)
      /// Write login
      internal static let title = L10n.tr("Localizable", "create_user.login.title", fallback: #"Write login"#)
    }
    internal enum Password {
      /// Password should not be empty
      internal static let hint = L10n.tr("Localizable", "create_user.password.hint", fallback: #"Password should not be empty"#)
      /// Write password
      internal static let title = L10n.tr("Localizable", "create_user.password.title", fallback: #"Write password"#)
    }
    internal enum PersonalWebPage {
      /// Web page url should not be empty
      internal static let hint = L10n.tr("Localizable", "create_user.personal_web_page.hint", fallback: #"Web page url should not be empty"#)
      /// Do your want to add
      /// personal web page link?
      internal static let optionTitle = L10n.tr("Localizable", "create_user.personal_web_page.option_title", fallback: #"Do your want to add\npersonal web page link?"#)
      /// Paste Your personal web page url
      internal static let title = L10n.tr("Localizable", "create_user.personal_web_page.title", fallback: #"Paste Your personal web page url"#)
    }
    internal enum Username {
      /// Username should not be empty
      internal static let hint = L10n.tr("Localizable", "create_user.username.hint", fallback: #"Username should not be empty"#)
      /// Write username
      internal static let title = L10n.tr("Localizable", "create_user.username.title", fallback: #"Write username"#)
    }
  }
  internal enum General {
    internal enum Alert {
      /// Cancel
      internal static let cancel = L10n.tr("Localizable", "general.alert.cancel", fallback: #"Cancel"#)
      /// Close
      internal static let close = L10n.tr("Localizable", "general.alert.close", fallback: #"Close"#)
    }
  }
  internal enum Home {
    /// Home
    internal static let title = L10n.tr("Localizable", "home.title", fallback: #"Home"#)
    internal enum Logout {
      /// Log out
      internal static let action = L10n.tr("Localizable", "home.logout.action", fallback: #"Log out"#)
      /// Are you sure you want to log out?
      internal static let message = L10n.tr("Localizable", "home.logout.message", fallback: #"Are you sure you want to log out?"#)
      /// Log out
      internal static let title = L10n.tr("Localizable", "home.logout.title", fallback: #"Log out"#)
    }
    internal enum Placeholder {
      /// Please log in
      internal static let description = L10n.tr("Localizable", "home.placeholder.description", fallback: #"Please log in"#)
      /// Sign In
      internal static let signIn = L10n.tr("Localizable", "home.placeholder.sign_in", fallback: #"Sign In"#)
      /// Sign Up
      internal static let signUp = L10n.tr("Localizable", "home.placeholder.sign_up", fallback: #"Sign Up"#)
      /// You are not logged
      internal static let title = L10n.tr("Localizable", "home.placeholder.title", fallback: #"You are not logged"#)
    }
    internal enum TableRow {
      /// Email
      internal static let email = L10n.tr("Localizable", "home.table_row.email", fallback: #"Email"#)
      /// ID
      internal static let id = L10n.tr("Localizable", "home.table_row.id", fallback: #"ID"#)
      /// Log Out
      internal static let logOut = L10n.tr("Localizable", "home.table_row.log_out", fallback: #"Log Out"#)
      /// Login
      internal static let login = L10n.tr("Localizable", "home.table_row.login", fallback: #"Login"#)
      /// Personal Web Page
      internal static let personalWebPage = L10n.tr("Localizable", "home.table_row.personal_web_page", fallback: #"Personal Web Page"#)
      /// User Role
      internal static let userRole = L10n.tr("Localizable", "home.table_row.user_role", fallback: #"User Role"#)
      /// Username
      internal static let username = L10n.tr("Localizable", "home.table_row.username", fallback: #"Username"#)
      /// Wallets
      internal static let wallets = L10n.tr("Localizable", "home.table_row.wallets", fallback: #"Wallets"#)
    }
    internal enum UsersList {
      /// Users List
      internal static let title = L10n.tr("Localizable", "home.users_list.title", fallback: #"Users List"#)
    }
  }
  internal enum Markets {
    internal enum Button {
      /// All
      internal static let all = L10n.tr("Localizable", "markets.button.all", fallback: #"All"#)
      /// Gainer
      internal static let gainer = L10n.tr("Localizable", "markets.button.gainer", fallback: #"Gainer"#)
      /// Loser
      internal static let loser = L10n.tr("Localizable", "markets.button.loser", fallback: #"Loser"#)
    }
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
  internal enum NewsList {
    /// News
    internal static let title = L10n.tr("Localizable", "news_list.title", fallback: #"News"#)
  }
  internal enum PostDetails {
    /// Post Details
    internal static let title = L10n.tr("Localizable", "post_details.title", fallback: #"Post Details"#)
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
  internal enum SignIn {
    /// Sign in
    internal static let title = L10n.tr("Localizable", "sign_in.title", fallback: #"Sign in"#)
    internal enum Login {
      /// Log in
      internal static let button = L10n.tr("Localizable", "sign_in.login.button", fallback: #"Log in"#)
      /// Login should not be empty
      internal static let hint = L10n.tr("Localizable", "sign_in.login.hint", fallback: #"Login should not be empty"#)
      /// Write login
      internal static let title = L10n.tr("Localizable", "sign_in.login.title", fallback: #"Write login"#)
    }
    internal enum Password {
      /// Password should not be empty
      internal static let hint = L10n.tr("Localizable", "sign_in.password.hint", fallback: #"Password should not be empty"#)
      /// Write password
      internal static let title = L10n.tr("Localizable", "sign_in.password.title", fallback: #"Write password"#)
    }
  }
  internal enum Tabbar {
    internal enum Title {
      /// Home
      internal static let home = L10n.tr("Localizable", "tabbar.title.home", fallback: #"Home"#)
      /// Markets
      internal static let markets = L10n.tr("Localizable", "tabbar.title.markets", fallback: #"Markets"#)
      /// News
      internal static let news = L10n.tr("Localizable", "tabbar.title.news", fallback: #"News"#)
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

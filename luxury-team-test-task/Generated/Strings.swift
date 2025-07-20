// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Strings {
  internal enum Common {
    internal enum Alert {
      internal enum Error {
        /// Error
        internal static let title = Strings.tr("Localizable", "common.alert.error.title", fallback: "Error")
      }
    }
    internal enum Button {
      internal enum Cancel {
        /// Cancel
        internal static let title = Strings.tr("Localizable", "common.button.cancel.title", fallback: "Cancel")
      }
      internal enum Close {
        /// Close
        internal static let title = Strings.tr("Localizable", "common.button.close.title", fallback: "Close")
      }
      internal enum Ok {
        /// ОК
        internal static let title = Strings.tr("Localizable", "common.button.ok.title", fallback: "ОК")
      }
    }
  }
  internal enum List {
    internal enum Search {
      /// Find company or ticker
      internal static let placeholder = Strings.tr("Localizable", "list.search.placeholder", fallback: "Find company or ticker")
      internal enum Empty {
        internal enum Section {
          /// Popular requests
          internal static let popular = Strings.tr("Localizable", "list.search.empty.section.popular", fallback: "Popular requests")
          /// You’ve searched for this
          internal static let searched = Strings.tr("Localizable", "list.search.empty.section.searched", fallback: "You’ve searched for this")
        }
      }
      internal enum Section {
        /// Show more
        internal static let more = Strings.tr("Localizable", "list.search.section.more", fallback: "Show more")
        /// Stocks
        internal static let title = Strings.tr("Localizable", "list.search.section.title", fallback: "Stocks")
      }
    }
    internal enum Tab {
      /// Favourite
      internal static let favourite = Strings.tr("Localizable", "list.tab.favourite", fallback: "Favourite")
      /// Stocks
      internal static let stocks = Strings.tr("Localizable", "list.tab.stocks", fallback: "Stocks")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Strings {
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

// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Cancel
  internal static let cancel = L10n.tr("Localizable", "cancel")
  /// close
  internal static let close = L10n.tr("Localizable", "Close")
  /// Dismiss
  internal static let dismiss = L10n.tr("Localizable", "dismiss")
  /// Error
  internal static let error = L10n.tr("Localizable", "Error")
  /// Signout
  internal static let logout = L10n.tr("Localizable", "logout")
  /// Do you want to signout?
  internal static let logoutMsg = L10n.tr("Localizable", "logoutMsg")
  /// No
  internal static let no = L10n.tr("Localizable", "no")
  /// Okay
  internal static let okay = L10n.tr("Localizable", "okay")
  /// Save
  internal static let save = L10n.tr("Localizable", "Save")
  /// Success
  internal static let success = L10n.tr("Localizable", "success")
  /// The session has expired and you will be logged out of the application
  internal static let unauthenticated = L10n.tr("Localizable", "Unauthenticated")
  /// Yes
  internal static let yes = L10n.tr("Localizable", "yes")

  internal enum EmptyData {
    /// It seems that there are no data to be displayed
    internal static let msg = L10n.tr("Localizable", "EmptyData.msg")
    /// Empty data
    internal static let title = L10n.tr("Localizable", "EmptyData.title")
  }

  internal enum Home {
    /// Home
    internal static let navTitle = L10n.tr("Localizable", "home.navTitle")
  }

  internal enum NoInternet {
    /// Reload page
    internal static let button = L10n.tr("Localizable", "noInternet.button")
    /// Try these steps to reconnect to the Internet:
    internal static let msg = L10n.tr("Localizable", "noInternet.msg")
    /// Reconnect to the cellular network
    internal static let step1 = L10n.tr("Localizable", "noInternet.step1")
    /// Reconnect to the Wi-Fi network
    internal static let step2 = L10n.tr("Localizable", "noInternet.step2")
    /// No internet connection
    internal static let title = L10n.tr("Localizable", "noInternet.title")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
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

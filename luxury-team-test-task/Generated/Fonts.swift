// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit.NSFont
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIFont
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "FontConvertible.Font", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias Font = FontConvertible.Font

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Fonts

// swiftlint:disable identifier_name line_length type_body_length
internal enum Fonts {
  internal enum Montserrat {
    internal static let black = FontConvertible(name: "Montserrat-Black", family: "Montserrat", path: "Montserrat-Black.ttf")
    internal static let blackItalic = FontConvertible(name: "Montserrat-BlackItalic", family: "Montserrat", path: "Montserrat-BlackItalic.ttf")
    internal static let bold = FontConvertible(name: "Montserrat-Bold", family: "Montserrat", path: "Montserrat-Bold.ttf")
    internal static let boldItalic = FontConvertible(name: "Montserrat-BoldItalic", family: "Montserrat", path: "Montserrat-BoldItalic.ttf")
    internal static let extraBold = FontConvertible(name: "Montserrat-ExtraBold", family: "Montserrat", path: "Montserrat-ExtraBold.ttf")
    internal static let extraBoldItalic = FontConvertible(name: "Montserrat-ExtraBoldItalic", family: "Montserrat", path: "Montserrat-ExtraBoldItalic.ttf")
    internal static let extraLight = FontConvertible(name: "Montserrat-ExtraLight", family: "Montserrat", path: "Montserrat-ExtraLight.ttf")
    internal static let extraLightItalic = FontConvertible(name: "Montserrat-ExtraLightItalic", family: "Montserrat", path: "Montserrat-ExtraLightItalic.ttf")
    internal static let italic = FontConvertible(name: "Montserrat-Italic", family: "Montserrat", path: "Montserrat-Italic.ttf")
    internal static let light = FontConvertible(name: "Montserrat-Light", family: "Montserrat", path: "Montserrat-Light.ttf")
    internal static let lightItalic = FontConvertible(name: "Montserrat-LightItalic", family: "Montserrat", path: "Montserrat-LightItalic.ttf")
    internal static let medium = FontConvertible(name: "Montserrat-Medium", family: "Montserrat", path: "Montserrat-Medium.ttf")
    internal static let mediumItalic = FontConvertible(name: "Montserrat-MediumItalic", family: "Montserrat", path: "Montserrat-MediumItalic.ttf")
    internal static let regular = FontConvertible(name: "Montserrat-Regular", family: "Montserrat", path: "Montserrat-Regular.ttf")
    internal static let semiBold = FontConvertible(name: "Montserrat-SemiBold", family: "Montserrat", path: "Montserrat-SemiBold.ttf")
    internal static let semiBoldItalic = FontConvertible(name: "Montserrat-SemiBoldItalic", family: "Montserrat", path: "Montserrat-SemiBoldItalic.ttf")
    internal static let thin = FontConvertible(name: "Montserrat-Thin", family: "Montserrat", path: "Montserrat-Thin.ttf")
    internal static let thinItalic = FontConvertible(name: "Montserrat-ThinItalic", family: "Montserrat", path: "Montserrat-ThinItalic.ttf")
    internal static let all: [FontConvertible] = [black, blackItalic, bold, boldItalic, extraBold, extraBoldItalic, extraLight, extraLightItalic, italic, light, lightItalic, medium, mediumItalic, regular, semiBold, semiBoldItalic, thin, thinItalic]
  }
  internal static let allCustomFonts: [FontConvertible] = [Montserrat.all].flatMap { $0 }
  internal static func registerAllCustomFonts() {
    allCustomFonts.forEach { $0.register() }
  }
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

internal struct FontConvertible {
  internal let name: String
  internal let family: String
  internal let path: String

  #if os(macOS)
  internal typealias Font = NSFont
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Font = UIFont
  #endif

  internal func font(size: CGFloat) -> Font {
    guard let font = Font(font: self, size: size) else {
      fatalError("Unable to initialize font '\(name)' (\(family))")
    }
    return font
  }

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal func swiftUIFont(size: CGFloat) -> SwiftUI.Font {
    return SwiftUI.Font.custom(self, size: size)
  }

  @available(iOS 14.0, tvOS 14.0, watchOS 7.0, macOS 11.0, *)
  internal func swiftUIFont(fixedSize: CGFloat) -> SwiftUI.Font {
    return SwiftUI.Font.custom(self, fixedSize: fixedSize)
  }

  @available(iOS 14.0, tvOS 14.0, watchOS 7.0, macOS 11.0, *)
  internal func swiftUIFont(size: CGFloat, relativeTo textStyle: SwiftUI.Font.TextStyle) -> SwiftUI.Font {
    return SwiftUI.Font.custom(self, size: size, relativeTo: textStyle)
  }
  #endif

  internal func register() {
    // swiftlint:disable:next conditional_returns_on_newline
    guard let url = url else { return }
    CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
  }

  fileprivate func registerIfNeeded() {
    #if os(iOS) || os(tvOS) || os(watchOS)
    if !UIFont.fontNames(forFamilyName: family).contains(name) {
      register()
    }
    #elseif os(macOS)
    if let url = url, CTFontManagerGetScopeForURL(url as CFURL) == .none {
      register()
    }
    #endif
  }

  fileprivate var url: URL? {
    // swiftlint:disable:next implicit_return
    return BundleToken.bundle.url(forResource: path, withExtension: nil)
  }
}

internal extension FontConvertible.Font {
  convenience init?(font: FontConvertible, size: CGFloat) {
    font.registerIfNeeded()
    self.init(name: font.name, size: size)
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Font {
  static func custom(_ font: FontConvertible, size: CGFloat) -> SwiftUI.Font {
    font.registerIfNeeded()
    return custom(font.name, size: size)
  }
}

@available(iOS 14.0, tvOS 14.0, watchOS 7.0, macOS 11.0, *)
internal extension SwiftUI.Font {
  static func custom(_ font: FontConvertible, fixedSize: CGFloat) -> SwiftUI.Font {
    font.registerIfNeeded()
    return custom(font.name, fixedSize: fixedSize)
  }

  static func custom(
    _ font: FontConvertible,
    size: CGFloat,
    relativeTo textStyle: SwiftUI.Font.TextStyle
  ) -> SwiftUI.Font {
    font.registerIfNeeded()
    return custom(font.name, size: size, relativeTo: textStyle)
  }
}
#endif

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

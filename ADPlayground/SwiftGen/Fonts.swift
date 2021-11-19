//
//  Colors.swift
//
//  Created by Adel Radwan
//
import UIKit.UIFont

 enum Fonts {
   enum cairo {
     static let black = FontConvertible(name: "Cairo-Black", family: "Cairo", path: "Cairo-Black.ttf")
     static let bold = FontConvertible(name: "Cairo-Bold", family: "Cairo", path: "Cairo-Bold.ttf")
     static let extraLight = FontConvertible(name: "Cairo-ExtraLight", family: "Cairo", path: "Cairo-ExtraLight.ttf")
     static let light = FontConvertible(name: "Cairo-Light", family: "Cairo", path: "Cairo-Light.ttf")
     static let regular = FontConvertible(name: "Cairo-Regular", family: "Cairo", path: "Cairo-Regular.ttf")
     static let semiBold = FontConvertible(name: "Cairo-SemiBold", family: "Cairo", path: "Cairo-SemiBold.ttf")
     static let all: [FontConvertible] = [black, bold, extraLight, light, regular, semiBold]
  }
   static let allCustomFonts: [FontConvertible] = [cairo.all].flatMap { $0 }
   static func registerAllCustomFonts() {
    allCustomFonts.forEach { $0.register() }
  }
}

// MARK: - Implementation Details

 struct FontConvertible {
   let name: String
   let family: String
   let path: String

   typealias Font = UIFont

   func font(size: CGFloat) -> Font {
    guard let font = Font(font: self, size: size) else { fatalError("Unable to initialize font '\(name)' (\(family))") }
    return font
  }

   func register() {
    guard let url = url else { return }
    CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
  }

  fileprivate var url: URL? {
    return BundleToken.bundle.url(forResource: path, withExtension: nil)
  }
}

 extension FontConvertible.Font {
  convenience init?(font: FontConvertible, size: CGFloat) {
    font.register()
    self.init(name: font.name, size: size)
  }

}

private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}

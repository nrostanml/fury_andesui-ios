//
//  AndesStyleSheet.swift
//  AndesUI
//
//  Created by LEANDRO FURYK on 04/12/2019.
//

import Foundation

@objc public protocol AndesStyleSheet: AndesColors, AndesFonts {}

/**
  AndesColors is used to create a new StyleSheet
  implementing all the necessary colors
*/
@objc public protocol AndesColors {

    /**
      The default colors that you need to override
      to use your color palette through all the UI components
    */
    var bgColorPrimary: UIColor { get }
    var bgColorSecondary: UIColor { get }
    var bgColorWhite: UIColor { get }

    var brandColor500: UIColor { get }

    var accentColor: UIColor { get }
    var accentColor100: UIColor { get }
    var accentColor150: UIColor { get }
    var accentColor200: UIColor { get }
    var accentColor300: UIColor { get }
    var accentColor400: UIColor { get }
    var accentColor500: UIColor { get }
    var accentColor600: UIColor { get }
    var accentColor700: UIColor { get }
    var accentColor800: UIColor { get }

    var textColorPrimary: UIColor { get }
    var textColorSecondary: UIColor { get }
    var textColorDisabled: UIColor { get }
    var textColorNegative: UIColor { get }
    var textColorCaution: UIColor { get }
    var textColorPositive: UIColor { get }
    @available(*, deprecated, renamed: "textColorLink")
    @objc optional var tetColorLink: UIColor { get }
    var textColorLink: UIColor { get }
    var textColorWhite: UIColor { get }
    var textColorWarning: UIColor { get }

    var feedbackColorNegative: UIColor { get }
    var feedbackColorCaution: UIColor { get }
    var feedbackColorPositive: UIColor { get }
    var feedbackColorWarning: UIColor { get }
}

public extension AndesColors {
    var tetColorLink: UIColor { return self.textColorLink }
}

/**
  AndesFonts is used to create a new StyleSheet
  implementing all the necessary fonts
*/
@objc public protocol AndesFonts {

    /**
      The default font variations that you need to override
      to use your own font through all the UI components.
      By default these return the SF system font
    */
    func titleXL(color: UIColor) -> AndesFontStyle
    func titleL(color: UIColor) -> AndesFontStyle
    func titleM(color: UIColor) -> AndesFontStyle
    func titleS(color: UIColor) -> AndesFontStyle
    func titleXS(color: UIColor) -> AndesFontStyle

    func bodyL(color: UIColor) -> AndesFontStyle
    func bodyM(color: UIColor) -> AndesFontStyle
    func bodyS(color: UIColor) -> AndesFontStyle
    func bodyXS(color: UIColor) -> AndesFontStyle

    func regularSystemFont(size: CGFloat) -> UIFont
    func lightSystemFont(size: CGFloat) -> UIFont
    func mediumSystemFontOfSize(size: CGFloat) -> UIFont
    func semiboldSystemFontOfSize(size: CGFloat) -> UIFont
}
